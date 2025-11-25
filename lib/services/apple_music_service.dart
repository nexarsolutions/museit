import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:music_kit/music_kit.dart';
import 'package:musit/globalModels/song_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppleMusicService extends GetxService {
  // Singleton
  static final AppleMusicService _instance = AppleMusicService._internal();

  factory AppleMusicService() => _instance;

  AppleMusicService._internal();

  final isConnected = false.obs;
  String? _developerToken;
  String? _userToken;

  // Developer token - should be obtained from your backend or stored securely
  // For now, using a placeholder. Replace with your actual token or fetch from backend
  static const String defaultDeveloperToken =
      "eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Iko2VTkyRkg4NloifQ.eyJpc3MiOiJVRzdKNFNSRDdCIiwiaWF0IjoxNzYzNzI2ODMxLCJleHAiOjE3NzkyNzg4MzF9.8UhU_sGV98douOBYrT7PVUMZzhy9I-Hbf7efKHmP0hYzNo59fXLvDi8i6JERGkvAx9KyPX_2roX1VcwO-LO0TA";

  final MusicKit _musicKit = MusicKit();

  /// Initialize the service and check connection status
  Future<void> init() async {
    await checkConnection();
  }

  /// Set developer token (can be fetched from backend)
  void setDeveloperToken(String token) {
    _developerToken = token;
  }

  /// Check if Apple Music is connected and authorizeUS
  Future<void> checkConnection() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedStatus = prefs.getBool('apple_music_connected');

      if (savedStatus == true) {
        // Check if still authorized
        final status = await _musicKit.authorizationStatus;
        if (status is MusicAuthorizationStatusAuthorized) {
          isConnected.value = true;
          // Try to refresh user token (but don't fail if it's not available)
          try {
            await _ensureUserToken();
          } catch (e) {
            // User token not available, but authorization is fine for catalog search
            debugPrint('⚠️ User token not available in checkConnection: $e');
          }
          return;
        }
      }

      isConnected.value = false;
    } catch (e) {
      debugPrint('❌ Apple Music connection check error: $e');
      isConnected.value = false;
    }
  }

  /// Connect to Apple Music (request authorization)
  /// This will authorize the app for Apple Music access
  /// User token will be attempted but connection can succeed even if it fails
  /// (catalog search works without user token, library operations require it)
  Future<void> connectAppleMusic() async {
    try {
      // Try to authenticate - user token is optional for basic connection
      await ensureAuthenticated(requireUserToken: false);
    } catch (e) {
      debugPrint('❌ Apple Music connection error: $e');
      // Provide more helpful error message
      if (e.toString().contains('permission not granted')) {
        throw Exception(
            "Apple Music permission was denied. Please enable it in Settings.");
      } else if (e.toString().contains('Privacy acknowledgement')) {
        throw Exception(
            "Apple Music setup incomplete. Please verify your developer token and privacy settings.");
      }
      rethrow;
    }
  }

  /// Ensure user is authenticated and authorized
  /// [requireUserToken] - if true, will attempt to get user token (required for library operations)
  /// if false, only checks authorization (sufficient for catalog search)
  Future<void> ensureAuthenticated({bool requireUserToken = false}) async {
    try {
      // Check current authorization status
      var status = await _musicKit.authorizationStatus;

      // Request authorization if not already authorized
      if (status is! MusicAuthorizationStatusAuthorized) {
        status = await _musicKit.requestAuthorizationStatus();
        if (status is! MusicAuthorizationStatusAuthorized) {
          isConnected.value = false;
          throw Exception("Apple Music permission not granted.");
        }
      }

      // Ensure we have developer token
      _developerToken ??= defaultDeveloperToken;

      // Get user token only if required (for library/playlist operations)
      if (requireUserToken) {
        await _ensureUserToken();
      } else {
        // Try to get user token but don't fail if it's not available
        // This allows catalog search to work even if user token fails
        try {
          await _ensureUserToken();
        } catch (e) {
          debugPrint(
              '⚠️ User token not available (catalog search will still work): $e');
          // Don't throw - catalog operations don't need user token
        }
      }

      // Save connection status
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('apple_music_connected', true);

      isConnected.value = true;
      debugPrint('✅ Apple Music connected');
    } catch (e) {
      isConnected.value = false;
      debugPrint('❌ Apple Music authentication error: $e');
      rethrow;
    }
  }

  /// Ensure user token is valid
  /// Returns true if token was obtained, false otherwise
  Future<bool> _ensureUserToken() async {
    try {
      if (_developerToken == null) {
        _developerToken = defaultDeveloperToken;
      }

      _userToken = await _musicKit.requestUserToken(_developerToken!);
      if (_userToken == null) {
        throw Exception("Unable to generate User Token.");
      }
      return true;
    } catch (e) {
      debugPrint('❌ User token error: $e');
      // Check if it's a privacy acknowledgement error
      if (e.toString().contains('Privacy acknowledgement required') ||
          e.toString().contains('ERR_REQUEST_USER_TOKEN')) {
        debugPrint('ℹ️ Privacy acknowledgement required. This may be due to:');
        debugPrint('   1. Developer token needs to be regenerated');
        debugPrint(
            '   2. Privacy acknowledgements needed in App Store Connect');
        debugPrint('   3. User needs to accept Apple Music terms in Settings');
        throw Exception(
            "Apple Music privacy acknowledgement required. Please check your developer token and privacy settings.");
      }
      rethrow;
    }
  }

  /// Get authorization status
  Future<MusicAuthorizationStatus> getAuthorizationStatus() async {
    return await _musicKit.authorizationStatus;
  }

  /// Request authorization
  Future<MusicAuthorizationStatus> requestAuthorization() async {
    return await _musicKit.requestAuthorizationStatus();
  }

  /// Search for songs in Apple Music catalog
  /// Note: Catalog search doesn't require user token, only developer token
  Future<List<SongModel>> searchSongs(String query, {int limit = 25}) async {
    try {
      // Catalog search only needs authorization, not user token
      await ensureAuthenticated(requireUserToken: false);

      final url = Uri.parse(
          "https://api.music.apple.com/v1/catalog/us/search?term=${Uri.encodeComponent(query)}&types=songs&limit=$limit");

      // Build headers - user token is optional for catalog search
      final headers = <String, String>{
        "Authorization": "Bearer $_developerToken",
      };
      if (_userToken != null) {
        headers["Music-User-Token"] = _userToken!;
      }

      final response = await http.get(url, headers: headers);

      if (response.statusCode != 200) {
        throw Exception("Failed to search songs: ${response.body}");
      }

      final json = jsonDecode(response.body);
      final List? songsData = json["results"]?["songs"]?["data"];

      if (songsData == null) {
        return [];
      }

      List<SongModel> songs = songsData.map((item) {
        final attributes = item["attributes"] ?? {};
        final artwork = attributes["artwork"] ?? {};
        final imageUrl = artwork["url"]
                ?.toString()
                .replaceAll('{w}', '300')
                .replaceAll('{h}', '300') ??
            "";

        return SongModel(
          type: "apple_music",
          name: attributes["name"] ?? "",
          link: item["href"] ?? "",
          image: imageUrl,
          id: int.tryParse(item["id"]?.toString() ?? ""),
        );
      }).toList();

      return songs;
    } catch (e) {
      debugPrint('❌ Search songs error: $e');
      rethrow;
    }
  }

  /// Fetch user's library songs
  /// Note: Library operations require user token
  Future<List<SongModel>> fetchUserLibrarySongs({int limit = 100}) async {
    try {
      // Library operations require user token
      await ensureAuthenticated(requireUserToken: true);

      final url = Uri.parse(
          "https://api.music.apple.com/v1/me/library/songs?limit=$limit");

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $_developerToken",
          "Music-User-Token": _userToken ?? "",
        },
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to fetch library songs: ${response.body}");
      }

      final json = jsonDecode(response.body);
      final List? items = json["data"];

      if (items == null) {
        return [];
      }

      List<SongModel> songs = items.map((item) {
        final attributes = item["attributes"] ?? {};
        final artwork = attributes["artwork"] ?? {};
        final imageUrl = artwork["url"]
                ?.toString()
                .replaceAll('{w}', '300')
                .replaceAll('{h}', '300') ??
            "";

        return SongModel(
          type: "apple_music",
          name: attributes["name"] ?? "",
          link: item["href"] ?? "",
          image: imageUrl,
          id: int.tryParse(item["id"]?.toString() ?? ""),
        );
      }).toList();

      return songs;
    } catch (e) {
      debugPrint('❌ Fetch library songs error: $e');
      rethrow;
    }
  }

  /// Fetch user's playlists
  /// Note: Playlist operations require user token
  Future<List<Map<String, dynamic>>> fetchUserPlaylists(
      {int limit = 100}) async {
    try {
      // Playlist operations require user token
      await ensureAuthenticated(requireUserToken: true);

      final url = Uri.parse(
          "https://api.music.apple.com/v1/me/library/playlists?limit=$limit");

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $_developerToken",
          "Music-User-Token": _userToken ?? "",
        },
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to fetch playlists: ${response.body}");
      }

      final json = jsonDecode(response.body);
      final List? playlistsData = json["data"];

      if (playlistsData == null) {
        return [];
      }

      List<Map<String, dynamic>> playlists = playlistsData.map((item) {
        final attributes = item["attributes"] ?? {};
        final artwork = attributes["artwork"] ?? {};
        final imageUrl = artwork["url"]
                ?.toString()
                .replaceAll('{w}', '300')
                .replaceAll('{h}', '300') ??
            "";

        return {
          "id": item["id"],
          "name": attributes["name"] ?? "",
          "description": attributes["description"]?.toString() ?? "",
          "href": item["href"] ?? "",
          "image": imageUrl,
          "songCount": attributes["playParams"]?["id"] ?? 0,
        };
      }).toList();

      return playlists;
    } catch (e) {
      debugPrint('❌ Fetch playlists error: $e');
      rethrow;
    }
  }

  /// Fetch songs from a specific playlist
  /// Note: Playlist operations require user token
  Future<List<SongModel>> fetchPlaylistSongs(String playlistId,
      {int limit = 100}) async {
    try {
      // Playlist operations require user token
      await ensureAuthenticated(requireUserToken: true);

      final url = Uri.parse(
          "https://api.music.apple.com/v1/me/library/playlists/$playlistId/tracks?limit=$limit");

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $_developerToken",
          "Music-User-Token": _userToken ?? "",
        },
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to fetch playlist songs: ${response.body}");
      }

      final json = jsonDecode(response.body);
      final List? items = json["data"];

      if (items == null) {
        return [];
      }

      List<SongModel> songs = items.map((item) {
        final attributes = item["attributes"] ?? {};
        final artwork = attributes["artwork"] ?? {};
        final imageUrl = artwork["url"]
                ?.toString()
                .replaceAll('{w}', '300')
                .replaceAll('{h}', '300') ??
            "";

        return SongModel(
          type: "apple_music",
          name: attributes["name"] ?? "",
          link: item["href"] ?? "",
          image: imageUrl,
          id: int.tryParse(item["id"]?.toString() ?? ""),
        );
      }).toList();

      return songs;
    } catch (e) {
      debugPrint('❌ Fetch playlist songs error: $e');
      rethrow;
    }
  }

  /// Get song details by ID
  /// Note: Catalog operations don't require user token
  Future<SongModel?> getSongDetails(String songId) async {
    try {
      // Catalog operations don't require user token
      await ensureAuthenticated(requireUserToken: false);

      final url =
          Uri.parse("https://api.music.apple.com/v1/catalog/us/songs/$songId");

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $_developerToken",
          "Music-User-Token": _userToken ?? "",
        },
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to get song details: ${response.body}");
      }

      final json = jsonDecode(response.body);
      final item = json["data"];

      if (item == null) {
        return null;
      }

      final attributes = item["attributes"] ?? {};
      final artwork = attributes["artwork"] ?? {};
      final imageUrl = artwork["url"]
              ?.toString()
              .replaceAll('{w}', '300')
              .replaceAll('{h}', '300') ??
          "";

      return SongModel(
        type: "apple_music",
        name: attributes["name"] ?? "",
        link: item["href"] ?? "",
        image: imageUrl,
        id: int.tryParse(item["id"]?.toString() ?? ""),
      );
    } catch (e) {
      debugPrint('❌ Get song details error: $e');
      return null;
    }
  }

  /// Get user token (for backend API calls if needed)
  /// Note: This requires privacy acknowledgement to be completed
  Future<String?> getUserToken() async {
    try {
      // User token is required for this method
      await ensureAuthenticated(requireUserToken: true);
      return _userToken;
    } catch (e) {
      debugPrint('❌ Get user token error: $e');
      return null;
    }
  }

  /// Get developer token
  String? getDeveloperToken() {
    return _developerToken ?? defaultDeveloperToken;
  }

  /// Disconnect Apple Music
  Future<void> disconnectAppleMusic() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('apple_music_connected');

      _userToken = null;
      isConnected.value = false;

      debugPrint('✅ Apple Music disconnected');
    } catch (e) {
      debugPrint('❌ Disconnect error: $e');
    }
  }

  /// Check if user has Apple Music subscription
  /// Note: This requires user token to access library
  Future<bool> hasAppleMusicSubscription() async {
    try {
      // Library access requires user token
      await ensureAuthenticated(requireUserToken: true);

      // Try to fetch user's library - if successful, user likely has subscription
      final url =
          Uri.parse("https://api.music.apple.com/v1/me/library/songs?limit=1");

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $_developerToken",
          "Music-User-Token": _userToken ?? "",
        },
      );

      // If we can access the library, user likely has subscription
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('❌ Check subscription error: $e');
      return false;
    }
  }

  /// Get recently played songs
  /// Note: This requires user token (uses library as fallback)
  Future<List<SongModel>> getRecentlyPlayed({int limit = 25}) async {
    try {
      // Note: Apple Music API doesn't have a direct "recently played" endpoint
      // This is a workaround - you might need to track this locally or use a different approach
      // For now, returning user library songs as a placeholder
      // fetchUserLibrarySongs already requires user token
      return await fetchUserLibrarySongs(limit: limit);
    } catch (e) {
      debugPrint('❌ Get recently played error: $e');
      return [];
    }
  }
}
