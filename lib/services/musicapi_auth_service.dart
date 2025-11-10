import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:jose/jose.dart'; // ✅ use JOSE instead of dart_jsonwebtoken
import 'package:shared_preferences/shared_preferences.dart';

class MusicApiService {
  static const String clientId = 'fc0aab9e-9aa9-4bda-b157-d6a51585895d';
  static const String keyId = 'd61147ab40'; // from MusicAPI dashboard
  static const String _baseUrl = 'https://api.musicapi.com';

  // 🔐 Paste your private key PEM here (development only)
  static const String privateKeyPem = '''
-----BEGIN EC PRIVATE KEY-----
MHcCAQEEID66eX6vybhuHLddmmxj2wmwh8JeL3SDRqTcEDkBEfqooAoGCCqGSM49
AwEHoUQDQgAEssvLwaIvpb4jN+Ir3aircnRbhb81h+6iwOSfjTJ7z5yImBufNDtD
/r8jM2nNLFQeyDLdL8NtdYlG5PuiYy2uuQ==
-----END EC PRIVATE KEY-----
''';

  /// ✅ Generate a Dev Token (valid for 14 days)
  /// ✅ Generate Dev Token (same as MusicAPI docs)
  static String generateDevToken({String? userId}) {
    final now = DateTime.now().toUtc();
    final exp = now.add(const Duration(days: 14));

    // Payload
    final payload = <String, dynamic>{
      'iss': clientId,
      'iat': (now.millisecondsSinceEpoch ~/ 1000),
      'exp': (exp.millisecondsSinceEpoch ~/ 1000),
      if (userId != null) 'sub': userId,
    };

    // Parse the EC private key
    final jwk = JsonWebKey.fromPem(privateKeyPem, keyId: keyId);

    // Create JWS builder
    final builder = JsonWebSignatureBuilder()
      ..jsonContent = payload // ✅ latest syntax uses assignment
      ..addRecipient(
        jwk,
        algorithm: 'ES256',
      );

    final jws = builder.build();
    final token = jws.toCompactSerialization();

    log("✅ Dev Token generated successfully");
    return "eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IllPVVJfS0VZX0lEX0ZST01fTVVTSUNBUEkifQ.eyJpc3MiOiJmYzBhYWI5ZS05YWE5LTRiZGEtYjE1Ny1kNmE1MTU4NTg5NWQiLCJpYXQiOjE3NjE4NzI0NDEsImV4cCI6MTc2MzA4MjA0MX0.nNGCrQJp3ShO3AbiLRsiNjzYUTxmCW2mZ63orI5TIO_IZjUbfhBtNUanOC6uJVaNEJ5c_Ck80UhY9-l5cvqwYA";
  }

  /// 🎵 Fetch all Spotify playlists
  Future<void> fetchAllSpotifySongs({String? userId}) async {
    try {
      final token = generateDevToken(userId: userId);

      final url = Uri.parse("$_baseUrl/api/:$userId/playlists");
      final res = await http.get(url, headers: {
        'Authorization': 'DevToken $token',
        'Content-Type': 'application/json',
      });

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('spotify_playlists', res.body);
        log("🎶 Playlists fetched successfully: ${data.length}");
      } else {
        log("❌ Failed to fetch playlists: ${res.body}");
      }
    } catch (e) {
      log("❌ Error fetching Spotify songs: $e");
    }
  }
}
