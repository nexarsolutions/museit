// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:musit/constants/colors.dart';
// import 'package:musit/globalModels/song_model.dart';
// import 'package:musit/pages/charity_side/charity_home/charity_add_songs/widget/add_songs_widget.dart';
// import 'package:musit/services/song_service.dart';
// import 'package:musit/utils/dialog_utilities.dart';
// import 'package:musit/widgets/custom_app_bar.dart';
// import 'package:musit/widgets/custom_button.dart';
// import 'package:musit/widgets/custom_text_field.dart';
// import '../../../../constants/text_styles.dart';
// import '../../../../widgets/audio_picker_widget.dart';
// import '../../../../widgets/custom_tab_button.dart';
// import '../sender_add_voice_note/sender_add_voice_note_screen.dart';
// import '../sender_create_playlist/controller/sender_create_playlist_controller.dart';
//
// class SenderAddSongsScreen extends StatelessWidget {
//   SenderAddSongsScreen({super.key});
//
//   final controller = Get.put(SenderCreatePlaylistController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: whiteColor,
//       body: Column(
//         children: [
//           CustomAppBar(text: 'Add Songs', isBack: true),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: CustomTextField(
//               borderRadius: 50,
//               controller: controller.searchController,
//               hintText: 'Search',
//               isSuffixIcon: true,
//               suffixIcon: Container(
//                 width: 36,
//                 height: 36,
//                 decoration: BoxDecoration(
//                   color: blackColor,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Image.asset('assets/images/search_icon.png', scale: 3),
//               ),
//               onChanged: (value) {
//                 if (value.trim().isEmpty) {
//                   controller.searchQuery.value = '';
//                 } else {
//                   controller.searchQuery.value = value.trim();
//                 }
//               },
//             ),
//           ),
//           SizedBox(height: 24),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Obx(
//               () => CustomTabButtonWithIcon(
//                 selectedIndex: controller.songTypeId.value,
//                 // GetX ya setState use kar sakte ho
//                 onTabSelected: (index) {
//                   controller.songTypeId.value = index;
//                 },
//                 tabs: [
//                   TabItem(
//                     title: "Spotify",
//                     selectedIcon: 'assets/images/spotify_selected.png',
//                     unselectedIcon: 'assets/images/spotify.png',
//                   ),
//                   TabItem(
//                     title: "Youtube",
//                     selectedIcon: 'assets/images/youtube_selected.png',
//                     unselectedIcon: 'assets/images/youtube.png',
//                   ),
//                   TabItem(
//                     title: "Apple Music",
//                     selectedIcon: 'assets/images/paid_icon_selected.png',
//                     unselectedIcon: 'assets/images/paid_icon.png',
//                   ),
//                   TabItem(
//                     title: "Upload",
//                     selectedIcon: 'assets/images/upload_selected.png',
//                     unselectedIcon: 'assets/images/upload.png',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 24),
//           Obx(
//             () => controller.songTypeId.value == 0
//                 ? Expanded(
//                     child: Center(
//                       child: Text("No Songs Found"),
//                     ),
//                   )
//                 : controller.songTypeId.value == 1
//                     ? Expanded(
//                         child: Center(
//                           child: Text("No Songs Found"),
//                         ),
//                       )
//                     : controller.songTypeId.value == 2
//                         ? Expanded(
//                             child: Center(
//                               child: Text("No Songs Found"),
//                             ),
//                           )
//                         : Expanded(
//                             child: Column(
//                               children: [
//                                 AudioPickerWidget(
//                                   onUploadComplete: (uploadedFileNames) {
//                                     for (var name in uploadedFileNames) {
//                                       final song = SongModel(
//                                         typeId: 4,
//                                         name: name.split('.').first, // optional
//                                         link: name,
//                                       );
//                                       controller.playlistModel.songs.add(song);
//                                     }
//                                   },
//                                 ),
//                                 SizedBox(
//                                   height: 16,
//                                 ),
//                                 Expanded(
//                                     child: Obx(
//                                   () => ListView.builder(
//                                     itemCount:
//                                         controller.playlistModel.songs.length,
//                                     itemBuilder: (context, index) {
//                                       final song =
//                                           controller.playlistModel.songs[index];
//
//                                       return song.typeId != 4
//                                           ? const SizedBox.shrink()
//                                           : AddSongsWidget(
//                                               song: song,
//                                               isSelected: false.obs,
//                                               showSelected: false,
//                                             );
//                                     },
//                                   ),
//                                 )),
//                               ],
//                             ),
//                           ),
//           ),
//           SizedBox(height: 24),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CustomButton(
//                   onPressed: () {
//                     if (controller.playlistModel.songs.isEmpty) {
//                       errorDialog(content: "Add songs to continue");
//                       return;
//                     }
//                     Get.to(() => SenderAddVoiceNoteScreen());
//                   },
//                   text: 'Save'),
//               /* SizedBox(width: 8),
//               Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Positioned(
//                     left: 1,
//                     right: 1,
//                     bottom: -3,
//                     child: Container(
//                       height: 30,
//                       width: 48,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(16),
//                           bottomRight: Radius.circular(16),
//                         ),
//                         color: blueColor,
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Get.to(() => SenderAddVoiceNoteScreen());
//                     },
//                     child: Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         color: blackColor,
//                       ),
//                       child: Image.asset(
//                         'assets/images/double_forwareded_icon.png',
//                         scale: 3,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//            */
//             ],
//           ),
//           SizedBox(height: 24),
//         ],
//       ),
//     );
//   }
// }
