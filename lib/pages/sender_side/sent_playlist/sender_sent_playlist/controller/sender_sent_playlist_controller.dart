// import 'package:get/get.dart';
// import 'package:musit/globalModels/playlist_model.dart';
// import 'package:musit/globalModels/sent_play_list_model.dart';
// import 'package:musit/services/api_service.dart';
// import 'package:musit/services/song_service.dart';
//
// import '../../../../../common_models/saved_playlist_model.dart';
//
// class SenderSentPlaylistController extends GetxController {
//   Future<List<SentPlaylistModel>> getSendPlaylist() async {
//     try {
//       List<SentPlaylistModel> playlistModelList = [];
//       await ApiService().handleGetResponse(
//         apiMethod: () => PlaylistService().sentPlaylistApi(),
//         onSuccess: (response) {
//           final sentResponse = SentPlaylistResponseModel.fromJson(response);
//           final playlist = sentResponse.response?.sentPlaylists ?? [];
//           if (playlist.isNotEmpty) {
//             playlistModelList.assignAll(playlist);
//           }
//         },
//         onError: (error) {
//           throw Exception(error);
//         },
//       );
//       return playlistModelList;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
