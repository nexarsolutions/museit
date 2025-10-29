import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/charity_side/charity_home/charity_add_songs/widget/add_songs_widget.dart';
import 'package:musit/pages/music_player/music_player_screen.dart';
import 'package:musit/services/auth_service.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_button.dart';
import 'package:musit/widgets/custom_text_field.dart';
import '../../../../constants/app_enums.dart';
import '../../../../constants/text_styles.dart';
import '../../../../globalModels/song_model.dart';
import '../../../../services/spotify_auth_service.dart';
import '../../../../utils/spotify_preview_url.dart';
import '../../../../widgets/audio_picker_widget.dart';
import '../../../../widgets/custom_tab_button.dart';
import '../../../../widgets/spotify_player.dart';
import '../voice_note/voice_note_screen.dart';
import 'controller/add_songs_controller.dart';

class AddSongsScreen extends StatelessWidget {
  AddSongsScreen({super.key});

  final controller = Get.put(AddSongsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Select Songs', isBack: true),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextField(
              borderRadius: 50,
              controller: controller.searchController,
              hintText: 'Search',
              isSuffixIcon: true,
              suffixIcon: GestureDetector(
                onTap: () => controller
                    .searchSong(controller.searchController.text.trim()),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: blackColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/images/search_icon.png', scale: 3),
                ),
              ),
              onChanged: (value) {
                if (value.trim().isEmpty) {
                  controller.searchQuery.value = '';
                } else {
                  controller.searchQuery.value = value.trim();
                }
              },
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Obx(
              () => CustomTabButtonWithIcon(
                selectedIndex: controller.songTypeId.value,
                // GetX ya setState use kar sakte ho
                onTabSelected: (index) {
                  controller.songTypeId.value = index;
                },
                tabs: [
                  TabItem(
                    title: "Spotify",
                    selectedIcon: 'assets/images/spotify_selected.png',
                    unselectedIcon: 'assets/images/spotify.png',
                  ),
                  TabItem(
                    title: "Youtube",
                    selectedIcon: 'assets/images/youtube_selected.png',
                    unselectedIcon: 'assets/images/youtube.png',
                  ),
                  TabItem(
                    title: "Apple",
                    selectedIcon: 'assets/images/selected_apple_music.png',
                    unselectedIcon: 'assets/images/unselected_apple_music.png',
                  ),
                  TabItem(
                    title: "Upload",
                    selectedIcon: 'assets/images/upload_selected.png',
                    unselectedIcon: 'assets/images/upload.png',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(
                () => controller.songTypeId.value == 0
                    ? !controller.isSpotifyConnected.value
                        ? _ConnectAccountPrompt(
                            serviceName: 'Spotify',
                            assetPath: 'assets/images/spotify_selected.png',
                            onPressed:
                                controller.connectSpotify, // or add logic below
                          )
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [

                                const SizedBox(height: 16),
                                if (controller.isSpotifyLoading.value)
                                  const Center(
                                      child: CircularProgressIndicator())
                                else if (controller.searchSpotifyResults.isEmpty)
                                  const Text("No songs found. Try searching.")
                                else
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount:
                                          controller.searchSpotifyResults.length,
                                      itemBuilder: (context, index) {
                                        final song =
                                            controller.searchSpotifyResults[index];
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: ListTile(
                                            leading: Image.network(
                                                song['image'],
                                                width: 50,
                                                fit: BoxFit.cover),
                                            title: Text(song['name']),
                                            subtitle: Text(song['artist']),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                      Icons.play_arrow),
                                                  onPressed: () =>
                                                  {/*
                                                    controller.playPreview(
                                                        song['previewUrl'])
                                                  */},
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.send),
                                                  onPressed: () => controller
                                                      .selectSong(song),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          )
                    : controller.songTypeId.value == 1
                        ? _ConnectAccountPrompt(
                            serviceName: 'YouTube',
                            assetPath: 'assets/images/youtube_selected.png',
                            onPressed: null,
                          )
                        : controller.songTypeId.value == 2
                            ? _ConnectAccountPrompt(
                                serviceName: 'Apple Music',
                                assetPath:
                                    'assets/images/selected_apple_music.png',
                                onPressed: null,
                              )
                            : Column(
                                children: [
                                  // AudioPickerWidget(
                                  //   onUploadComplete: (uploadedFileNames) {
                                  //     for (var name in uploadedFileNames) {
                                  //       final song = SongModel(
                                  //         typeId: 4,
                                  //         name: name[AudioKey.name], //
                                  //         // optional
                                  //         link: name[AudioKey.path],
                                  //       );
                                  //       controller.songs.add(song);
                                  //     }
                                  //   },
                                  // ),
                                  // SizedBox(
                                  //   height: 8,
                                  // ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Text(
                                          //   "Uploaded Songs",
                                          //   style: manRopeSemiBold,
                                          // ).marginSymmetric(vertical: 8),
                                          // Obx(
                                          //   () => ListView.builder(
                                          //     shrinkWrap: true,
                                          //     primary: false,
                                          //     padding: EdgeInsets.zero,
                                          //     itemCount:
                                          //         controller.songs.length,
                                          //     itemBuilder: (context, index) {
                                          //       final song =
                                          //           controller.songs[index];
                                          //
                                          //       return song.typeId != 4
                                          //           ? const SizedBox.shrink()
                                          //           : GestureDetector(
                                          //               onTap: () {
                                          //                 Get.to(() =>
                                          //                     MusicPlayerScreen(
                                          //                         songTitle:
                                          //                             song.name ??
                                          //                                 'N/A',
                                          //                         songUrl:
                                          //                             song.link ??
                                          //                                 '',
                                          //                         imagePath:
                                          //                             /* song.image ??*/
                                          //                             ''));
                                          //               },
                                          //               child: AddSongsWidget(
                                          //                 song: song,
                                          //                 isSelected: false.obs,
                                          //                 showSelected: false,
                                          //               ),
                                          //             );
                                          //     },
                                          //   ),
                                          // ),
                                          Text(
                                            "Library",
                                            style: manRopeSemiBold,
                                          ).marginSymmetric(vertical: 8),
                                          Obx(
                                            () => ListView.builder(
                                              shrinkWrap: true,
                                              primary: false,
                                              padding: EdgeInsets.zero,
                                              itemCount:
                                                  controller.library.length,
                                              itemBuilder: (context, index) {
                                                final song =
                                                    controller.library[index];

                                                return Obx(
                                                  () {
                                                    bool isSelected = controller
                                                        .librarySelected.value
                                                        .any(
                                                      (element) =>
                                                          element.link ==
                                                          song.link,
                                                    );

                                                    return GestureDetector(
                                                      onTap: () {
                                                        Get.to(() =>
                                                            MusicPlayerScreen(
                                                                songTitle:
                                                                    song.name ??
                                                                        'N/A',
                                                                songUrl:
                                                                    song.link ??
                                                                        '',
                                                                imagePath:
                                                                    /* song.image ??*/
                                                                    ''));
                                                      },
                                                      child: AddSongsWidget(
                                                        song: song,
                                                        isSelected:
                                                            isSelected.obs,
                                                        showSelected: true,
                                                        onTap: () {
                                                          controller
                                                              .librarySelected
                                                              .add(song);
                                                        },
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
              ),
            ),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                  onPressed: () {
                    if (controller.librarySelected.isNotEmpty) {
                      Get.to(() => VoiceNoteScreen());
                    } else {
                      customErrorSnackBar(content: "Select song to continue");
                    }
                  },
                  text: 'Save'),
              // SizedBox(width: 8),
              // Stack(
              //   clipBehavior: Clip.none,
              //   children: [
              //     Positioned(
              //       left: 1,
              //       right: 1,
              //       bottom: -3,
              //       child: Container(
              //         height: 30,
              //         width: 48,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadiusGeometry.only(
              //             bottomLeft: Radius.circular(16),
              //             bottomRight: Radius.circular(16),
              //           ),
              //           color: blueColor,
              //         ),
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         Get.to(() => VoiceNoteScreen());
              //       },
              //       child: Container(
              //         width: 50,
              //         height: 50,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(16),
              //           color: blackColor,
              //         ),
              //         child: Image.asset(
              //           'assets/images/double_forwareded_icon.png',
              //           scale: 3,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ConnectAccountPrompt extends StatelessWidget {
  final String serviceName;
  final String assetPath;
  final void Function()? onPressed;

  const _ConnectAccountPrompt({
    super.key,
    required this.serviceName,
    required this.assetPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: blackColor,
            child: Center(child: Image.asset(assetPath, height: 20)),
          ),
          const SizedBox(height: 16),
          Text(
            "Connect your $serviceName account to browse songs",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: "Connect $serviceName",
            onPressed: onPressed ??
                () {
                  customErrorSnackBar(content: "Coming Soon");
                },
          ),
        ],
      ),
    );
  }
}
