import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SpotifyAuthService {
  // ---------- Singleton ----------
  SpotifyAuthService._internal();

  static final SpotifyAuthService _instance = SpotifyAuthService._internal();

  factory SpotifyAuthService() {
    // _instance._connectSpotify();
    return _instance;
  }



  RxnString? userEmail;
  RxnString? trackName;

  // ---------- Config ----------
  static const clientId =
      '846dc9e59ed6404cb240b0ff0d0162c1'; // Replace with your Spotify App Client ID
  static const redirectUri = 'com.museit://spotify-callback';
  static const scopes =
      'user-read-email user-read-private user-read-playback-state user-modify-playback-state';
  static const tokenUrl = 'https://accounts.spotify.com/api/token';

  // ---------- Memory cache ----------
  String? _accessToken;
  String? _refreshToken;
  DateTime? _expiry;
  String? _codeVerifier;

  Future<void> connectSpotify() async {
    await ensureAuthenticated();
    final token = await SpotifyAuthService().getAccessToken();
    print("Access token: $token");

    // Get user info
    final res = await http.get(
      Uri.parse('https://api.spotify.com/v1/me'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
       userEmail = data['email'];
    }

    // Example: search a song
    final songRes = await http.get(
      Uri.parse(
          'https://api.spotify.com/v1/search?q=Believer&type=track&limit=1'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (songRes.statusCode == 200) {
      final data = jsonDecode(songRes.body);
      final track = data['tracks']['items'][0];
      trackName = track['name'];
    }
  }

  // ---------- Utils ----------
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

  // ---------- Public API ----------
  Future<void> ensureAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken ??= prefs.getString('spotify_access_token');
    _refreshToken ??= prefs.getString('spotify_refresh_token');
    final expiryString = prefs.getString('spotify_token_expiry');
    if (expiryString != null) _expiry = DateTime.tryParse(expiryString);

    if (_accessToken != null &&
        _expiry != null &&
        DateTime.now().isBefore(_expiry!)) {
      print('✅ Using cached Spotify token');
      return;
    }

    if (_refreshToken != null) {
      final refreshed = await _refreshAccessToken();
      if (refreshed) return;
    }

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

    if (await canLaunchUrl(authUrl)) {
      await launchUrl(authUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open Spotify auth page';
    }
  }

  Future<void> handleRedirect(Uri uri) async {
    final prefs = await SharedPreferences.getInstance();
    _codeVerifier ??= prefs.getString('spotify_code_verifier');
    final code = uri.queryParameters['code'];

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
      await _saveTokens(
          data['access_token'], data['refresh_token'], data['expires_in']);
      print('✅ Spotify tokens stored');
    } else {
      print('❌ Token exchange failed: ${response.body}');
    }
  }

  Future<String?> getAccessToken() async {
    await ensureAuthenticated();
    return _accessToken;
  }

  Future<void> _saveTokens(String? access, String? refresh,
      int? expiresIn) async {
    if (access == null) return;
    final prefs = await SharedPreferences.getInstance();
    _accessToken = access;
    _refreshToken = refresh ?? _refreshToken;
    _expiry = DateTime.now().add(Duration(seconds: expiresIn ?? 3600));

    await prefs.setString('spotify_access_token', _accessToken!);
    if (_refreshToken != null)
      await prefs.setString('spotify_refresh_token', _refreshToken!);
    await prefs.setString('spotify_token_expiry', _expiry!.toIso8601String());
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
      await _saveTokens(data['access_token'],
          data['refresh_token'] ?? _refreshToken, data['expires_in']);
      print('🔁 Spotify token refreshed');
      return true;
    }
    print('❌ Failed to refresh token: ${res.body}');
    return false;
  }
}
