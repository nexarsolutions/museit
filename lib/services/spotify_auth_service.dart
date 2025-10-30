import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
}
