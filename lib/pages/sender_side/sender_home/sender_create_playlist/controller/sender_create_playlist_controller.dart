// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:musit/constants/global_list.dart';
// import 'package:musit/globalModels/playlist_model.dart';
// import 'package:musit/services/upload_file_service.dart';
// import 'package:musit/utils/dialog_utilities.dart';
//
// import '../../../../../globalModels/song_model.dart';
// import '../../../../../services/api_service.dart';
// import '../../../../../services/song_service.dart';
// import '../../sender_created_playlist/sender_created_playlist_screen.dart';
//
// class SenderCreatePlaylistController extends GetxController {
//   final PlaylistModel playlistModel = PlaylistModel();
//
//   RxnString selectedPurpose = RxnString();
//   RxInt songTypeId = 0.obs;
//
//   final _fileService = UploadFileService();
//   final _apiService = ApiService();
//   final _playlistService = PlaylistService();
//
//   final searchController = TextEditingController();
//   RxString searchQuery = ''.obs;
//
//   Future<void> createPlaylist(RxList<SongModel> recordingList) async {
//     try {
//       playlistModel.purposeId = getPurposeIndex();
//       var data = playlistModel.toJson();
//
//       if (playlistModel.image.value != '') {
//         try {
//           String? imageUrl = await _fileService.fileUploadResult(
//               uploadData: playlistModel.image.value);
//           if (imageUrl != '') {
//             data['image'] = imageUrl ?? '';
//           } else {
//             return;
//           }
//         } catch (e) {
//           errorDialog(content: e.toString());
//           return;
//         }
//       }
//
//       if (recordingList.isNotEmpty) {
//         List<String> recordingPaths = recordingList
//             .map((e) => e.link)
//             .whereType<String>()
//             .where((path) => path.isNotEmpty)
//             .toList();
//
//         if (recordingPaths.isEmpty) {
//           errorDialog(content: "Something went wrong try again later");
//           return;
//         }
//
//         try {
//           List<String> recordingUrls =
//               await _fileService.uploadMultipleImagesFast(recordingPaths);
//           if (recordingUrls.isNotEmpty) {
//             data['voiceNotes'] = recordingUrls
//                 .map((vc) => {"name": vc.split('.').first, "link": vc})
//                 .toList();
//           }
//         } catch (e) {
//           errorDialog(content: e.toString());
//           return;
//         }
//       }
//
//       await _apiService.handleResponse(
//         apiMethod: () => _playlistService.createPlaylist(data),
//         onSuccess: (response) async {
//           printInfo(info: "success response: $response");
//           int? playListId = response['response']['id'];
//           await Future.delayed(Duration(seconds: 2));
//           Get.close(3); //close last three screen
//           // Get.to(() => SenderAddVoiceNoteScreen(playListId: playListId));
//           Get.off(() => SenderCreatedPlaylistScreen(playListId: playListId));
//           successDialog(content: response['message']);
//           playlistModel.clear();
//           selectedPurpose.value = null;
//           songTypeId.value = 0;
//           searchQuery.value = '';
//         },
//       );
//     } catch (e) {
//       errorDialog(content: e.toString());
//     }
//   }
//
//   int getPurposeIndex() {
//     return playlistPurposes.indexOf(selectedPurpose.value!);
//   }
//
//   List<SongModel> getUploadedSongs() {
//     return playlistModel.songs
//         .where(
//           (songs) => songs.typeId == 4,
//         )
//         .toList();
//   }
// }
