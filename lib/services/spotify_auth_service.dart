import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'musicapi_auth_service.dart';

class SpotifyAuthService extends GetxService {
  // Singleton
  static final SpotifyAuthService _instance = SpotifyAuthService._internal();

  factory SpotifyAuthService() => _instance;

  SpotifyAuthService._internal();

  final isConnected = false.obs;
  String? _accessToken;
  String? _refreshToken;
  DateTime? _expiry;
  String? _codeVerifier;

  static const clientId = '846dc9e59ed6404cb240b0ff0d0162c1';
  static const redirectUri = 'com.museit://spotify-callback';
  static const returnURL = 'myapp://auth-callback';
  static const scopes =
      'user-read-email user-read-private user-read-playback-state user-modify-playback-state';
  static const tokenUrl = 'https://accounts.spotify.com/api/token';

  Future<void> checkConnection() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('spotify_access_token');
    final expiryString = prefs.getString('spotify_token_expiry');

    if (token != null && expiryString != null) {
      final expiry = DateTime.tryParse(expiryString);
      if (expiry != null && DateTime.now().isBefore(expiry)) {
        _accessToken = token;
        _refreshToken = prefs.getString('spotify_refresh_token');
        _expiry = expiry;
        isConnected.value = true;
        return;
      }
    }
    isConnected.value = false;
  }

  Future<void> connectSpotify() async => await ensureAuthenticated();

  Future<void> ensureAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('spotify_access_token');
    _refreshToken = prefs.getString('spotify_refresh_token');
    final expiryString = prefs.getString('spotify_token_expiry');
    if (expiryString != null) _expiry = DateTime.tryParse(expiryString);
    print(
        'Checking Spotify connection... $_accessToken $_refreshToken $_expiry');
    print("************* 0");

    // ✅ Valid cached token
    if (_accessToken != null &&
        _expiry != null &&
        DateTime.now().isBefore(_expiry!)) {
      print("************* 1");
      isConnected.value = true;
      return;
    }
    print("************* 2");

    // 🔁 Refresh if possible
    if (_refreshToken != null && await _refreshAccessToken()) return;

    // 🚀 Full auth flow
    await authenticate();
  }

  Future<void> authenticate() async {
    final prefs = await SharedPreferences.getInstance();
    _codeVerifier = _generateCodeVerifier();
    await prefs.setString('spotify_code_verifier', _codeVerifier!);

    final codeChallenge = _generateCodeChallenge(_codeVerifier!);
    final authUrl = Uri.https('accounts.spotify.com', '/authorize', {
      'client_id': clientId,
      'response_type': 'code',
      'redirect_uri': redirectUri,
      'scope': scopes,
      'code_challenge_method': 'S256',
      'code_challenge': codeChallenge,
    });
    print("*********** 4");

    if (!await launchUrl(authUrl, mode: LaunchMode.externalApplication)) {
      throw 'Could not open Spotify auth page';
    }
    print("*********** 5");
  }

  Future<void> handleRedirect(Uri uri) async {
    final code = uri.queryParameters['code'];
    print("*********** 6");
    final prefs = await SharedPreferences.getInstance();
    _codeVerifier ??= prefs.getString('spotify_code_verifier');

    if (code == null || _codeVerifier == null) return;

    final response = await http.post(
      Uri.parse(tokenUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'client_id': clientId,
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': redirectUri,
        'code_verifier': _codeVerifier!,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _saveTokens(data);
      print('✅ Spotify connected');
    } else {
      print('❌ Auth failed: ${response.body}');
    }
  }

  Future<bool> _refreshAccessToken() async {
    if (_refreshToken == null) return false;
    print("************* 3");
    final res = await http.post(
      Uri.parse(tokenUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'client_id': clientId,
        'grant_type': 'refresh_token',
        'refresh_token': _refreshToken!,
      },
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      await _saveTokens(data);
      print('🔁 Token refreshed');
      return true;
    }
    print('❌ Refresh failed: ${res.body}');
    return false;
  }

  Future<void> _saveTokens(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = data['access_token'];
    _refreshToken = data['refresh_token'] ?? _refreshToken;
    _expiry = DateTime.now().add(Duration(seconds: data['expires_in'] ?? 3600));

    await prefs.setString('spotify_access_token', _accessToken!);
    if (_refreshToken != null) {
      await prefs.setString('spotify_refresh_token', _refreshToken!);
    }
    await prefs.setString('spotify_token_expiry', _expiry!.toIso8601String());

    isConnected.value = true;
  }

  Future<String?> getAccessToken() async {
    await ensureAuthenticated();
    return _accessToken;
  }

  String _generateCodeVerifier() {
    final random = Random.secure();
    final values = List<int>.generate(64, (_) => random.nextInt(256));
    return base64UrlEncode(values).replaceAll('=', '');
  }

  String _generateCodeChallenge(String verifier) {
    final bytes = utf8.encode(verifier);
    final digest = sha256.convert(bytes);
    return base64UrlEncode(digest.bytes).replaceAll('=', '');
  }

  // the music API implementation
  // the music API implementation
  // the music API implementation
  // the music API implementation
  // the music API implementation

  Future<void> openSpotifyAuth() async {
    final encoded = Uri.encodeComponent(returnURL);

    final authUrl =
        'https://app.musicapi.com/museit-life/spotify/auth?returnUrl=$encoded';
    final uri = Uri.parse(authUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open $authUrl';
    }
  }

  // void handleRedirectMusicAPi(Uri uri) {
  //   final encoded = uri.queryParameters['data64'];
  //   if (encoded == null) {
  //     print('❌ No data64 parameter found in URI');
  //     return;
  //   }
  //
  //   try {
  //     // Step 1: Decode base64
  //     final decodedBytes = base64.decode(Uri.decodeComponent(encoded));
  //     final decodedString = utf8.decode(decodedBytes);
  //
  //     // Step 2: Parse JSON
  //     final data = jsonDecode(decodedString);
  //     print('✅ Decoded Spotify Auth Data: $data');
  //
  //     // Step 3: Extract useful values
  //     final status = data['authModel']?['status'];
  //     final userUUID = data['authModel']?['uuid'];
  //     final integrationUserUUID = data['integrationUserUUID'];
  //
  //     print('🎵 Status: $status');
  //     print('🧩 Integration User UUID: $integrationUserUUID');
  //
  //     // Optional: Save to storage or make follow-up API calls
  //     if (status == 'success') {
  //       // You can now hit your backend or MusicAPI to fetch user playlists etc.
  //     }
  //   } catch (e) {
  //     print('❌ Failed to decode data64: $e');
  //   }
  // }
  Future<void> handleRedirectMusicAPi(Uri uri) async {
    final prefs = await SharedPreferences.getInstance();

    final encoded = uri.queryParameters['data64'];
    if (encoded == null) {
      print('❌ No data64 parameter found in URI');
      return;
    }

    try {
      // Decode base64
      final decodedBytes = base64.decode(Uri.decodeComponent(encoded));
      final decodedString = utf8.decode(decodedBytes);
      final data = jsonDecode(decodedString);

      print('✅ Decoded Spotify Auth Data: $data');

      final status = data['authModel']?['status'];
      final integrationUserUUID = data['integrationUserUUID'];
      print("---===df=d=f");
      print(integrationUserUUID);

      if (status == 'success' && integrationUserUUID != null) {
        // Save UUID locally
        await prefs.setString('spotify_user_uuid', integrationUserUUID);
        await prefs.setString('spotify_auth_data', jsonEncode(data));
        print('💾 Spotify data saved locally.');

        // 🎵 Fetch songs now
        final musicApi = MusicApiService();
        await musicApi.fetchAllSpotifySongs(userId: integrationUserUUID);

        print('🎶 All Spotify songs fetched and saved!');
      } else {
        print('⚠️ Spotify authentication failed or missing UUID.');
      }
    } catch (e) {
      print('❌ Failed to decode data64: $e');
    }
  }

  /// Fetches user’s saved Spotify tracks directly from MusicAPI

  /// Fetches playlists and all songs inside them (fallback method)
// Future<List<Map<String, dynamic>>> fetchUserPlaylistsAndSongs() async {
//   final prefs = await SharedPreferences.getInstance();
//   final integrationUserUUID = prefs.getString('spotify_user_uuid');
//
//   if (integrationUserUUID == null) {
//     print('⚠️ No Spotify user found in local storage.');
//     return [];
//   }
//
//   try {
//     // Step 1: Fetch playlists
//     final playlistUrl = Uri.parse(
//         '$_baseUrl/spotify/playlists?integrationUserUUID=$integrationUserUUID');
//     final playlistRes = await http.get(playlistUrl);
//
//     if (playlistRes.statusCode != 200) {
//       print('❌ Failed to fetch playlists: ${playlistRes.statusCode}');
//       return [];
//     }
//
//     final playlists = List<Map<String, dynamic>>.from(
//         jsonDecode(playlistRes.body)['playlists'] ?? []);
//     final allTracks = <Map<String, dynamic>>[];
//
//     // Step 2: Fetch tracks from each playlist
//     for (final playlist in playlists) {
//       final playlistId = playlist['id'];
//       final tracksUrl = Uri.parse(
//           '$_baseUrl/spotify/playlist/tracks?integrationUserUUID=$integrationUserUUID&playlistId=$playlistId');
//       final tracksRes = await http.get(tracksUrl);
//
//       if (tracksRes.statusCode == 200) {
//         final tracks = List<Map<String, dynamic>>.from(
//             jsonDecode(tracksRes.body)['tracks'] ?? []);
//         allTracks.addAll(tracks);
//       }
//     }
//
//     print('🎧 Combined total ${allTracks.length} songs from all playlists.');
//     return allTracks;
//   } catch (e) {
//     print('❌ Exception while fetching playlists: $e');
//     return [];
//   }
// }

// String generateDevToken({
//   required String clientId,
//   required String keyId,
//   required String privateKeyPem,
//   String? integrationUserUUID,
// }) {
//   // Parse the private key from PEM format
//   final ecPrivateKey = ECPrivateKey(privateKeyPem);
//
//   // Current time
//   final now = DateTime.now();
//
//   // Create JWT
//   final jwt = JWT(
//     {
//       'iss': clientId,
//       'iat': (now.millisecondsSinceEpoch / 1000).floor(),
//       'exp':
//           (now.add(Duration(days: 14)).millisecondsSinceEpoch / 1000).floor(),
//       if (integrationUserUUID != null) 'sub': integrationUserUUID,
//     },
//     header: {
//       'alg': 'ES256',
//       'kid': keyId,
//       'typ': 'JWT',
//     },
//   );
//
//   // Sign the JWT with ES256 algorithm using your private key
//   final token = jwt.sign(ecPrivateKey, algorithm: JWTAlgorithm.ES256);
//
//   return token;
// }
}
/*import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class SpotifyAuthService extends GetxService {
  // Singleton
  static final SpotifyAuthService _instance = SpotifyAuthService._internal();

  factory SpotifyAuthService() => _instance;

  SpotifyAuthService._internal();

  final isConnected = false.obs;
  String? _accessToken;
  String? _refreshToken;
  DateTime? _expiry;

  static const clientId = '846dc9e59ed6404cb240b0ff0d0162c1';
  static const redirectUri = 'com.museit://spotify-callback';
  static const scopes =
      'user-read-email user-read-private user-read-playback-state user-modify-playback-state';
  static const tokenUrl = 'https://accounts.spotify.com/api/token';

  Future<void> checkConnection() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('spotify_access_token');
    final expiryString = prefs.getString('spotify_token_expiry');

    if (token != null && expiryString != null) {
      final expiry = DateTime.tryParse(expiryString);
      if (expiry != null && DateTime.now().isBefore(expiry)) {
        _accessToken = token;
        _refreshToken = prefs.getString('spotify_refresh_token');
        _expiry = expiry;
        isConnected.value = true;
        return;
      }
    }
    isConnected.value = false;
  }

  Future<void> connectSpotify() async => await ensureAuthenticated();

  Future<void> ensureAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('spotify_access_token');
    _refreshToken = prefs.getString('spotify_refresh_token');
    final expiryString = prefs.getString('spotify_token_expiry');
    if (expiryString != null) _expiry = DateTime.tryParse(expiryString);

    // ✅ Valid cached token
    if (_accessToken != null &&
        _expiry != null &&
        DateTime.now().isBefore(_expiry!)) {
      isConnected.value = true;
      return;
    }

    // 🔁 Refresh token if available
    if (_refreshToken != null && await _refreshAccessToken()) return;

    // 🚀 Full auth flow with Spotify SDK
    await authenticate();
  }

  Future<void> authenticate() async {
    try {
      final accessToken = await SpotifySdk.getAccessToken(
        clientId: clientId,
        redirectUrl: redirectUri,
        scope: scopes,
      );

      if (accessToken != null && accessToken.isNotEmpty) {
        _accessToken = accessToken;
        _expiry = DateTime.now().add(const Duration(hours: 1));

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('spotify_access_token', _accessToken!);
        await prefs.setString(
            'spotify_token_expiry', _expiry!.toIso8601String());

        isConnected.value = true;
        print('✅ Spotify connected via SDK');
      } else {
        print('❌ Failed to retrieve access token via Spotify SDK');
      }
    } catch (e) {
      print('❌ Spotify SDK auth error: $e');
    }
  }

  Future<bool> _refreshAccessToken() async {
    if (_refreshToken == null) return false;
    final res = await http.post(
      Uri.parse(tokenUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'client_id': clientId,
        'grant_type': 'refresh_token',
        'refresh_token': _refreshToken!,
      },
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      await _saveTokens(data);
      print('🔁 Token refreshed');
      return true;
    }
    print('❌ Refresh failed: ${res.body}');
    return false;
  }

  Future<void> _saveTokens(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = data['access_token'];
    _refreshToken = data['refresh_token'] ?? _refreshToken;
    _expiry = DateTime.now().add(Duration(seconds: data['expires_in'] ?? 3600));

    await prefs.setString('spotify_access_token', _accessToken!);
    if (_refreshToken != null) {
      await prefs.setString('spotify_refresh_token', _refreshToken!);
    }
    await prefs.setString('spotify_token_expiry', _expiry!.toIso8601String());

    isConnected.value = true;
  }

  Future<String?> getAccessToken() async {
    await ensureAuthenticated();
    return _accessToken;
  }
}*/
