// /*
//  * Author: Affine Sol (PVT LTD) - https://affinesol.com/
//  * Last Modified: 15/11/2025 at 12:17:17
//  */
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:music_kit/music_kit.dart';
//
// import '../common_models/song_model.dart';
//
// class AppleMusicService {
//   static const developerToken = "YOUR_DEVELOPER_TOKEN";
//
//   /// Fetch full Apple Music Library Songs
//   static Future<List<SongModel>> fetchUserSongs() async {
//     // 1. Check Apple Music availability
//     final musicKit = MusicKit();
//     var status = await musicKit.authorizationStatus;
//
//     if (status is! MusicAuthorizationStatusAuthorized) {
//       status = await musicKit.requestAuthorizationStatus();
//       if (status is! MusicAuthorizationStatusAuthorized) {
//         throw Exception("Apple Music permission not granted");
//       }
//     }
//     bool isAvailable = await musicKit.a();
//     if (!isAvailable) {
//       throw Exception("Apple Music is not available on this device.");
//     }
//
//     // 2. Request Authorization
//     final status = await musicKit.authorizationStatus();
//     if (status != AuthorizationStatus.authorized) {
//       final authResult = await musicKit.authorize();
//       if (authResult != AuthorizationStatus.authorized) {
//         throw Exception("User did not grant Apple Music permissions.");
//       }
//     }
//
//     // 3. Get User Token
//     final userToken = await musicKit.userToken;
//     if (userToken == null)
//       throw Exception("Unable to get Apple Music User Token.");
//
//     // 4. Call REST API to fetch library songs
//     final url =
//         Uri.parse("https://api.music.apple.com/v1/me/library/songs?limit=100");
//
//     final response = await http.get(
//       url,
//       headers: {
//         "Authorization": "Bearer $developerToken",
//         "Music-User-Token": userToken,
//       },
//     );
//
//     if (response.statusCode != 200) {
//       throw Exception("Failed to fetch songs: ${response.body}");
//     }
//
//     final data = jsonDecode(response.body);
//     final List items = data["data"];
//
//     // 5. Map to SongModel list
//     List<SongModel> songs = items.map((item) {
//       return SongModel(
//         link: item["href"] ?? "",
//         imagePath: '',
//         songName: item["attributes"]?["name"] ?? "",
//         length: '',
//       );
//     }).toList();
//
//     return songs;
//   }
// }
