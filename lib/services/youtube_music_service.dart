// import 'dart:convert';
//
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:musit/services/api_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class YouTubeMusicAuthService extends GetxService {
//   // Singleton
//   static final YouTubeMusicAuthService _instance =
//       YouTubeMusicAuthService._internal();
//
//   factory YouTubeMusicAuthService() => _instance;
//
//   YouTubeMusicAuthService._internal();
//
//   final isConnected = false.obs;
//
//   // Google Sign-In instance configured for YouTube scope
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'email',
//       'https://www.googleapis.com/auth/youtube.readonly',
//     ],
//     serverClientId: '161844591519-997cfjaja5rja9d61idn7m0cbnp6bkok'
//         '.apps.googleusercontent.com',
//   );
//
//   // --- API 4: Check Connection Status (GET youtube-music/status) ---
//   Future<void> checkConnection() async {
//     try {
//       await ApiService().handleGetResponse(
//         apiMethod: ()  async => await ApiService().get('youtube-music/status'),
//         onSuccess: (success) {
//
//           isConnected.value = success['response']['connected'] ?? false;
//         },
//         onError: (error) {
//
//           isConnected.value = false;
//         },
//       );
//
//       // final url = Uri.parse('${ApiService.baseUrl}youtube-music/status');
//       // final response = await http.get(url);
//       //
//       // if (response.statusCode == 200) {
//       //   final data = json.decode(response.body);
//       //   isConnected.value = data['response']['connected'] ?? false;
//       // } else {
//       //   isConnected.value = false;
//       //   print(
//       //       '❌ YT Status check failed (${response.statusCode}): ${response.body}');
//       // }
//     } catch (e) {
//       isConnected.value = false;
//       print('YT Status check error: $e');
//     }
//   }
//
//   Future<void> connectYouTubeMusic() async {
//     try {
//       // print('🎬 Starting YouTube Music connection flow...');
//       // final GoogleSignInAccount? account = await _googleSignIn.signIn();
//       //
//       // if (account == null) {
//       //   print('🚫 User cancelled sign-in.');
//       //   return;
//       // }
//       //
//       // print('✅ Google account selected: ${account.email}');
//       // final GoogleSignInAuthentication auth = await account.authentication;
//       // print('🔑 AccessToken: ${auth.accessToken != null}');
//       // print('🔑 ServerAuthCode: ${account.serverAuthCode != null}');
//       //
//       // final accessToken = auth.accessToken;
//       // final serverAuthCode = account.serverAuthCode;
//       //
//       // if (accessToken != null && serverAuthCode != null) {
//       //   print('📡 Sending tokens to backend...');
//       await _sendTokensToBackend('accessToken', 'serverAuthCode');
//       // } else {
//       //   print('❌ Missing accessToken or serverAuthCode!');
//       //   isConnected.value = false;
//       // }
//     } catch (error) {
//       print('🔥 YouTube Music Sign-In Error: $error');
//       isConnected.value = false;
//     }
//   }
//
//   // --- Helper function to call your custom backend API 1 ---
//   Future<void> _sendTokensToBackend(
//       String accessToken, String serverAuthCode) async {
//     final url = Uri.parse('${ApiService.baseUrl}youtube-music/connect');
//
//     print('POSTing to backend: $url');
//
//     await ApiService().handleGetResponse(
//       apiMethod: () async => await ApiService().post("youtube-music/connect", {
//         "accessToken":
//             "ya29.a0ATi6K2vz9Rrip0tvqvqSRFfiJXTsSARP8u_YOxMUsihBdWxIboIOtOMTBJvJPe_RFulViHnoVNKcA3CRXLVGttZrxljt1FB9lD0unOd2k854KrZUNJpPI1YMQXv1phFKMrmQ8KDnzHLPT3rqTVXE3Fzkmh-XPB1YzUmKXOy3CByDHV_IBdOIhnYD7PfF9CEi6_f_RX8aCgYKAaoSARcSFQHGX2Mi1gt407aKg-9jud_FOR1J8Q0206",
//         "refreshToken":
//             "1//042MojrnLGkIKCgYIARAAGAQSNwF-L9IrWgnpvfqS_CDBd85HS-2uzKtC2TPDq9R-FVb8_lJzGkPiizrkmUFnO8PEqbWj3AkqQJY"
//       }),
//       onSuccess: (success) async {
//         isConnected.value = success['response']['connected'] ?? false;
//         if (isConnected.value) {
//           print('✅ YouTube Music account connected successfully via backend.');
//           // Optionally save a flag/timestamp to SharedPreferences if needed
//           final prefs = await SharedPreferences.getInstance();
//           await prefs.setBool('yt_music_connected', true);
//         }
//       },
//       onError: (error) {
//         isConnected.value = false;
//       },
//     );
//     // print('Payload: ${json.encode({
//     //   "accessToken": accessToken,
//     //   "refreshToken": serverAuthCode,
//     // })}');
//     // print('Headers: ${{"Content-Type": "application/json"}}');
//
//     // Your backend expects "refreshToken", so we send the 'serverAuthCode' here.
//     // The backend is responsible for securely exchanging this code for the actual Refresh Token.
//     // final response = await http.post(
//     //   url,
//     //   headers: {'Content-Type': 'application/json'},
//     //   body: json.encode({
//     //     "accessToken":
//     //         "ya29.a0ATi6K2vz9Rrip0tvqvqSRFfiJXTsSARP8u_YOxMUsihBdWxIboIOtOMTBJvJPe_RFulViHnoVNKcA3CRXLVGttZrxljt1FB9lD0unOd2k854KrZUNJpPI1YMQXv1phFKMrmQ8KDnzHLPT3rqTVXE3Fzkmh-XPB1YzUmKXOy3CByDHV_IBdOIhnYD7PfF9CEi6_f_RX8aCgYKAaoSARcSFQHGX2Mi1gt407aKg-9jud_FOR1J8Q0206",
//     //     "refreshToken":
//     //         "1//042MojrnLGkIKCgYIARAAGAQSNwF-L9IrWgnpvfqS_CDBd85HS-2uzKtC2TPDq9R-FVb8_lJzGkPiizrkmUFnO8PEqbWj3AkqQJY"
//     //   }),
//     // );
//
//     // print('Response: ${response.statusCode} → ${response.body}');
//     //
//     // if (response.statusCode == 200) {
//     //   final data = json.decode(response.body);
//     //   isConnected.value = data['response']['connected'] ?? false;
//     //   if (isConnected.value) {
//     //     print('✅ YouTube Music account connected successfully via backend.');
//     //     // Optionally save a flag/timestamp to SharedPreferences if needed
//     //     final prefs = await SharedPreferences.getInstance();
//     //     await prefs.setBool('yt_music_connected', true);
//     //   }
//     // } else {
//     //   isConnected.value = false;
//     //   print(
//     //       '❌ Backend Connect API Failed (${response.statusCode}): ${response.body}');
//     // }
//   }
//
//   // --- API 3: Disconnect YT Music (DELETE youtube-music/disconnect) ---
//   Future<void> disconnectYouTubeMusic() async {
//     try {
//       final url = Uri.parse('${ApiService.baseUrl}youtube-music/disconnect');
//       final response = await http.delete(url);
//
//       if (response.statusCode == 200) {
//         isConnected.value = false;
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.remove('yt_music_connected');
//         print('✅ YouTube Music account disconnected successfully.');
//       } else {
//         print(
//             '❌ Disconnect API Failed (${response.statusCode}): ${response.body}');
//       }
//     } catch (e) {
//       print('YT Disconnect error: $e');
//     }
//   }
// }
