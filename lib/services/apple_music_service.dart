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

  /// Validate if a string is a numeric catalog ID (e.g., "1456311004")
  /// Returns true if the string contains only digits
  bool _isNumericCatalogId(String id) {
    if (id.isEmpty) return false;
    // Check if it's a numeric string (catalog IDs are numeric)
    // Exclude ISRCs (like "USUG11904763") and other non-numeric formats
    return RegExp(r'^\d+$').hasMatch(id);
  }

  /// Fetch user's library songs
  /// Note: Library operations require user token
  Future<List<SongModel>> fetchUserLibrarySongs({int limit = 100}) async {
    try {
      // Library operations require user token
      await ensureAuthenticated(requireUserToken: true);

      // Include catalog relationship to get catalog song IDs
      final url = Uri.parse(
          "https://api.music.apple.com/v1/me/library/songs?limit=$limit&include=catalog");

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
      final List? included = json["included"];

      if (items == null) {
        return [];
      }

      // Build a map of catalog songs from the included array
      // Key: catalog song ID (numeric string), Value: catalog song data
      final Map<String, dynamic> catalogSongsMap = {};
      if (included != null) {
        for (var includedItem in included) {
          if (includedItem["type"] == "songs" && includedItem["id"] != null) {
            final catalogId = includedItem["id"]?.toString() ?? "";
            // Validate it's a numeric catalog ID (not ISRC or other format)
            if (catalogId.isNotEmpty && _isNumericCatalogId(catalogId)) {
              catalogSongsMap[catalogId] = includedItem;
            }
          }
        }
      }

      List<SongModel> songs = items.map((item) {
        final attributes = item["attributes"] ?? {};
        final artwork = attributes["artwork"] ?? {};
        final imageUrl = artwork["url"]
                ?.toString()
                .replaceAll('{w}', '300')
                .replaceAll('{h}', '300') ??
            "";

        // Extract library song ID
        final librarySongId = item["id"]?.toString() ?? "";
        final href = item["href"]?.toString() ?? "";

        // Try to get catalog song ID from relationships
        String? catalogSongId;
        final relationships = item["relationships"] ?? {};
        final catalogData = relationships["catalog"]?["data"];

        if (catalogData != null && catalogData.isNotEmpty) {
          final catalogId = catalogData[0]["id"]?.toString() ?? "";
          // Validate it's a numeric catalog ID
          if (_isNumericCatalogId(catalogId)) {
            catalogSongId = catalogId;
          } else {
            // If the ID in relationships is not numeric, try to find it in included array
            // by matching via href or other identifiers
            debugPrint(
                '⚠️ Catalog ID from relationships is not numeric: $catalogId');
          }
        }

        // If not found in relationships, check playParams
        if (catalogSongId == null || catalogSongId.isEmpty) {
          final playParams = attributes["playParams"] ?? {};
          final catalogId = playParams["catalogId"]?.toString() ?? "";
          if (_isNumericCatalogId(catalogId)) {
            catalogSongId = catalogId;
          }
        }

        // If still not found, try to match from included array via relationships
        if ((catalogSongId == null || catalogSongId.isEmpty) &&
            catalogData != null &&
            catalogData.isNotEmpty) {
          final catalogHref = catalogData[0]["href"]?.toString() ?? "";
          // Try to find matching catalog song in included array
          for (var entry in catalogSongsMap.entries) {
            final catalogItem = entry.value;
            if (catalogItem["href"]?.toString() == catalogHref) {
              final foundId = entry.key;
              if (_isNumericCatalogId(foundId)) {
                catalogSongId = foundId;
                break;
              }
            }
          }
        }

        // Store both library song ID and catalog song ID in the link field
        // Format: /v1/me/library/songs/i.ZOMrKa1SrEPK64q|catalog:1456311004
        final linkWithCatalog =
            catalogSongId != null && catalogSongId.isNotEmpty
                ? "$href|catalog:$catalogSongId"
                : href;

        if (catalogSongId != null && catalogSongId.isNotEmpty) {
          debugPrint(
              '✅ Found numeric catalog ID: $catalogSongId for library song: $librarySongId');
        } else {
          debugPrint(
              '⚠️ No valid numeric catalog ID found for library song: $librarySongId');
        }

        // Try to parse library song ID as int (for compatibility), but store string in link
        return SongModel(
          type: "apple_music",
          name: attributes["name"] ?? "",
          link: linkWithCatalog, // Store link with catalog ID appended
          image: imageUrl,
          id: int.tryParse(librarySongId) ??
              0, // Try to parse, but we'll use link for actual ID
        );
      }).toList();

      return songs;
    } catch (e) {
      debugPrint('❌ Fetch library songs error: $e');
      rethrow;
    }
  }

  /// Get catalog song ID from library song
  /// Library songs need to be played using their catalog song ID
  Future<String?> getCatalogSongIdFromLibrarySong(String librarySongId) async {
    try {
      await ensureAuthenticated(requireUserToken: true);

      // Fetch the library song details to get catalog song relationship
      final url = Uri.parse(
          "https://api.music.apple.com/v1/me/library/songs/$librarySongId");

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $_developerToken",
          "Music-User-Token": _userToken ?? "",
        },
      );

      if (response.statusCode != 200) {
        debugPrint('❌ Failed to fetch library song details: ${response.body}');
        return null;
      }

      final json = jsonDecode(response.body);
      final data = json["data"];

      // Check for catalog song relationship
      final relationships = data["relationships"] ?? {};
      final catalogData = relationships["catalog"]?["data"];

      if (catalogData != null && catalogData.isNotEmpty) {
        final catalogSongId = catalogData[0]["id"]?.toString() ?? "";
        // Validate it's a numeric catalog ID
        if (_isNumericCatalogId(catalogSongId)) {
          debugPrint('✅ Found numeric catalog song ID: $catalogSongId');
          return catalogSongId;
        } else {
          debugPrint(
              '⚠️ Catalog ID from relationships is not numeric: $catalogSongId');
        }
      }

      // If no catalog relationship, try to get it from attributes
      final attributes = data["attributes"] ?? {};
      final playParams = attributes["playParams"] ?? {};
      final catalogId = playParams["catalogId"]?.toString() ?? "";

      if (catalogId.isNotEmpty && _isNumericCatalogId(catalogId)) {
        debugPrint('✅ Found numeric catalog ID from playParams: $catalogId');
        return catalogId;
      }

      debugPrint(
          '⚠️ No catalog song ID found for library song: $librarySongId');
      return null;
    } catch (e) {
      debugPrint('❌ Error getting catalog song ID: $e');
      return null;
    }
  }

  /// Play an Apple Music library song using MusicKit
  /// [librarySongId] - The library song ID (e.g., "i.ZOMrKa1SrEPK64q")
  /// [link] - Optional link that may contain catalog ID (format: link|catalog:ID)
  Future<void> playLibrarySong(String librarySongId, {String? link}) async {
    try {
      await ensureAuthenticated(requireUserToken: true);

      // Initialize MusicKit with tokens
      await _musicKit.initialize(
        _developerToken ?? defaultDeveloperToken,
        musicUserToken: _userToken,
      );

      // Try to extract catalog song ID from link first (if we stored it there)
      String? catalogSongId;
      if (link != null && link.contains('|catalog:')) {
        final parts = link.split('|catalog:');
        if (parts.length > 1) {
          final extractedId = parts[1];
          // Validate it's a numeric catalog ID
          if (_isNumericCatalogId(extractedId)) {
            catalogSongId = extractedId;
            debugPrint(
                '🎵 Found valid numeric catalog ID in link: $catalogSongId');
          } else {
            debugPrint('⚠️ Catalog ID in link is not numeric: $extractedId');
          }
        }
      }

      // If not in link or invalid, fetch it from API
      if (catalogSongId == null || catalogSongId.isEmpty) {
        final fetchedId = await getCatalogSongIdFromLibrarySong(librarySongId);
        if (fetchedId != null && _isNumericCatalogId(fetchedId)) {
          catalogSongId = fetchedId;
        } else if (fetchedId != null) {
          debugPrint('⚠️ Fetched catalog ID is not numeric: $fetchedId');
        }
      }

      // Library songs are typically not directly playable, so use catalog song ID
      // MUST be a numeric catalog ID (e.g., "1456311004"), not ISRC or other format
      if (catalogSongId != null &&
          catalogSongId.isNotEmpty &&
          _isNumericCatalogId(catalogSongId)) {
        debugPrint('🎵 Playing with numeric catalog song ID: $catalogSongId');
        await _musicKit.setQueue(
          'songs',
          item: {'id': catalogSongId},
        );
        await _musicKit.play();
        debugPrint('✅ Playing catalog song: $catalogSongId');
        return;
      }

      // Fallback: try playing library song directly (may not work)
      debugPrint('⚠️ No catalog ID found, trying library song directly');
      try {
        await _musicKit.setQueue(
          'library-songs',
          item: {'id': librarySongId},
        );
        await _musicKit.play();
        debugPrint('✅ Playing library song: $librarySongId');
      } catch (e) {
        throw Exception(
            'Could not play library song. Library song ID: $librarySongId. Library songs typically require catalog song ID to play. Error: $e');
      }
    } catch (e) {
      debugPrint('❌ Error playing Apple Music song: $e');
      rethrow;
    }
  }

  /// Get current playback state stream
  Stream<MusicPlayerState> get playbackState =>
      _musicKit.onMusicPlayerStateChanged;

  /// Pause playback
  Future<void> pause() async {
    try {
      await _musicKit.pause();
    } catch (e) {
      debugPrint('❌ Error pausing: $e');
    }
  }

  /// Resume playback
  Future<void> resume() async {
    try {
      await _musicKit.play();
    } catch (e) {
      debugPrint('❌ Error resuming: $e');
    }
  }

  /// Seek to position
  /// Note: Seek functionality may not be available in all music_kit versions
  Future<void> seekTo(Duration position) async {
    try {
      // Try to seek - method name may vary by package version
      // If this doesn't work, seek functionality may not be available
      debugPrint(
          '⚠️ Seek functionality may not be available in music_kit package');
    } catch (e) {
      debugPrint('❌ Error seeking: $e');
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
