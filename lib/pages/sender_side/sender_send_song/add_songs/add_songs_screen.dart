import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/main.dart';
import 'package:musit/pages/charity_side/charity_home/charity_add_songs/widget/add_songs_widget.dart';
import 'package:musit/pages/music_player/music_player_screen.dart';
import 'package:musit/pages/sendBottombar/controller/sender_bottom_bar_controller.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_button.dart';
import 'package:musit/widgets/custom_text_field.dart';
import 'package:musit/widgets/error_widget_future_stream.dart';
import 'package:musit/widgets/web_view_screen.dart';

import '../../../../globalModels/song_model.dart';
import '../../../../services/spotify_auth_service.dart';
import '../../../../widgets/custom_tab_button.dart';
import '../../../../widgets/youtube_player_widget.dart';
import '../voice_note/voice_note_screen.dart';
import 'controller/add_songs_controller.dart';

class AddSongsScreen extends StatelessWidget {

  AddSongsScreen({super.key});

  final controller = Get.put(AddSongsController());
  final SpotifyAuthService spotifyService = Get.find<SpotifyAuthService>();

  // final YouTubeMusicAuthService ytMusicService =
  //     Get.find<YouTubeMusicAuthService>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(
        children: [
          CustomAppBar(text: 'MUSEiT Moment', isBack: false),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextField(
              borderRadius: 50,
              controller: controller.searchController,
              hintText: 'Search songs',
              onChanged: (value){
                controller.searchQuery.value = value.trim();
                if(controller.songTypeId.value==1 && value.trim().isNotEmpty){
                  controller.searchInYoutubeList.value=RxList<Map<String, String>>.from(controller.youtubeSongsList.where((value) => value['name']!.toLowerCase().contains(controller.searchQuery.value.toLowerCase())));
                }
              },
              isSuffixIcon: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  if(controller.songTypeId.value==1 && controller.searchQuery.value.trim().isNotEmpty){
                    controller.searchInYoutubeList.value=RxList<Map<String, String>>.from(controller.youtubeSongsList.where((value) => value['name']!.toLowerCase().contains(controller.searchQuery.value.toLowerCase())));
                  }else{
                    controller
                        .searchSong(controller.searchController.text.trim());
                  }
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: blackColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/images/search_icon.png', scale: 3),
                ),
              ),
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
                    selectedColor: Color(0xFF1db954)
                  ),
                  TabItem(
                    title: "Youtube",
                    selectedIcon: 'assets/images/youtube_selected.png',
                    unselectedIcon: 'assets/images/youtube.png',
                    selectedColor: Color(0xFFFF0000)
                  ),
                  TabItem(
                    title: "Apple",
                    selectedIcon: 'assets/images/selected_apple_music.png',
                    unselectedIcon: 'assets/images/unselected_apple_music.png',
                    selectedColor: Color(0xFFFF4E6B)
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(
                () => controller.songTypeId.value == 0
                    ? Obx(() {
                        return controller.spotifyService.isConnected.value
                            ? _buildspotifyWidget()
                            : _ConnectAccountPrompt(
                                serviceName: 'Spotify',
                                assetPath: 'assets/images/spotify_selected.png',
                                onPressed: spotifyService.openSpotifyAuth,
                              );
                      })
                    : controller.songTypeId.value == 1
                        ? _buildYoutubeWidget(
                  youtubeSongs:
                    controller.searchQuery.value.trim().isEmpty
                        ?controller.youtubeSongsList.value
                        :controller.searchInYoutubeList.value) // Create this widget next

                        : controller.songTypeId.value == 2
                            ? _ConnectAccountPrompt(
                                serviceName: 'Apple Music',
                                assetPath:
                                    'assets/images/selected_apple_music.png',
                                onPressed: null,
                              )
                            : Obx(
                                () => FutureBuilder(
                                    key: ValueKey(controller.searchQuery.value),
                                    future: controller.loadAdminSongs(
                                        search: controller.searchQuery.value),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return ErrorWidgetFutureStream();
                                      }

                                      if (snapshot.hasError) {
                                        return ErrorWidgetFutureStream(
                                          error: snapshot.error.toString(),
                                        );
                                      }

                                      if (!snapshot.hasData ||
                                          snapshot.data == null ||
                                          snapshot.data!.isEmpty) {
                                        return ErrorWidgetFutureStream(
                                          error: "Empty",
                                        );
                                      }

                                      final adminSongs = snapshot.requireData;

                                      return ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        padding: EdgeInsets.zero,
                                        itemCount: adminSongs.length,
                                        itemBuilder: (context, index) {
                                          final aSong = adminSongs[index];

                                          final song = SongModel(
                                            typeId: 4,
                                            link: aSong.link,
                                            id: aSong.id,
                                            name: aSong.name,
                                          );

                                          return Obx(
                                            () {
                                              bool isSelected =
                                                  controller.songs.value.any(
                                                (element) =>
                                                    element.link == song.link,
                                              );

                                              return GestureDetector(
                                                onTap: () {
                                                  Get.to(() =>
                                                      MusicPlayerScreen(
                                                          songTitle:
                                                              song.name ??
                                                                  'N/A',
                                                          songUrl:
                                                              song.link ?? '',
                                                          imagePath:
                                                              /* song.image ??*/
                                                              ''));
                                                },
                                                child: AddSongsWidget(
                                                  song: song,
                                                  isSelected: isSelected.obs,
                                                  showSelected: true,
                                                  onTap: () {
                                                    bool? isAlreadySelected =
                                                        controller.songs.any(
                                                      (element) =>
                                                          element.link ==
                                                          song.link,
                                                    );
                                                    if (isAlreadySelected) {
                                                      controller.songs
                                                          .removeWhere(
                                                              (element) =>
                                                                  element
                                                                      .link ==
                                                                  song.link);
                                                    } else {
                                                      controller.songs.clear();
                                                      controller.songs.add(
                                                          song..typeId = 4);
                                                    }
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    }),
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
                    if (controller.songs.isNotEmpty) {
                      Get.to(() => VoiceNoteScreen());
                    } else {
                      customErrorSnackBar(content: "Select song to continue");
                    }
                  },
                  text: 'Save'),
            ],
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Column _buildspotifyWidget() {
    return Column(
      children: [
        // const SizedBox(height: 16),
        if (controller.isSpotifyLoading.value)
          const Center(child: CircularProgressIndicator())
        else if (controller.searchSpotifyResults.isEmpty)
          const Center(child: CircularProgressIndicator())
        else
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            primary: false,
            itemCount: controller.searchSpotifyResults.length,
            itemBuilder: (context, index) {
              final spotifySong = controller.searchSpotifyResults[index];

              final song = SongModel(
                typeId: 1,
                name: spotifySong['name'],
                link: spotifySong['uri'],
                // artist: spotifySong['artists'][0]['name'],
                image: spotifySong['image'],
              );

              return Obx(
                () {
                  bool isSelected = controller.songs.value.any(
                    (element) => element.link == song.link,
                  );

                  return GestureDetector(
                    onTap: () {
                      String trackId =
                          spotifySong['uri'].toString().split(':').last;
                      String trackName = spotifySong['name'];

                      Get.to(() => WebViewScreen(
                          title: trackName,
                          url: 'https://open'
                              '.spotify'
                              '.com/embed/track/$trackId'));
                      // Get.to(() =>
                      //     MusicPlayerScreen(
                      //         songTitle:
                      //             song.name ??
                      //                 'N/A',
                      //         songUrl:
                      //             song.link ?? '',
                      //         imagePath:
                      //             /* song.image ??*/
                      //             ''));
                    },
                    child: AddSongsWidget(
                      song: song,
                      isSelected: isSelected.obs,
                      showSelected: true,
                      onTap: () {
                        bool? isAlreadySelected = controller.songs.any(
                          (element) => element.link == song.link,
                        );
                        if (isAlreadySelected) {
                          controller.songs.removeWhere(
                              (element) => element.link == song.link);
                        } else {
                          controller.songs.clear();
                          controller.songs.add(song..typeId = 1);
                        }
                      },
                    ),
                  );
                },
              );
            },
          ),
      ],
    );
  }

  Column _buildYoutubeWidget({required List<Map<String, String>> youtubeSongs}) {
    return Column(
      children: [
        // const SizedBox(height: 16),
        // if (controller.isYoutubeLoading.value)
        //   const Center(child: CircularProgressIndicator())
        if (youtubeSongs.isEmpty)
          // const Center(child: CircularProgressIndicator())
          Text("${youtubeSongs.length}")
        else
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.zero,
            itemCount: youtubeSongs.length,
            itemBuilder: (context, index) {
              final youtubeSong = youtubeSongs[index];

              final song = SongModel(
                typeId: 2,
                name: youtubeSong["name"],
                image: '',
                // artist: spotifySong['artists'][0]['name'],
                link: youtubeSong["videoId"],
              );

              return Obx(
                () {
                  bool isSelected = controller.songs.value.any(
                    (element) => element.link == song.link,
                  );

                  return GestureDetector(
                    onTap: () {
                      String playUrl = 'https://www.youtube'
                          '.com/watch?v=${youtubeSong["videoId"] ?? ''}';
                      print("*** youtube url: $playUrl");

                      Get.to(() => YouTubeAudioPlayer(
                            videoUrl: playUrl,
                          ));
                      // Get.to(() => WebViewScreen(
                      //     title: youtubeSong.name ?? '', url: playUrl));
                      // Get.to(() => MusicPlayerScreen(
                      //     songTitle: song.name ?? 'N/A',
                      //     songUrl: song.link ?? '',
                      //     imagePath:
                      //         /* song.image ??*/
                      //         ''));
                    },
                    child: AddSongsWidget(
                      song: song,
                      isSelected: isSelected.obs,
                      showSelected: true,
                      onTap: () {
                        bool? isAlreadySelected = controller.songs.any(
                          (element) => element.link == song.link,
                        );
                        if (isAlreadySelected) {
                          controller.songs.removeWhere(
                              (element) => element.link == song.link);
                        } else {
                          controller.songs.clear();
                          controller.songs.add(song..typeId = 2);
                        }
                      },
                    ),
                  );
                },
              );
            },
          ),
      ],
    );
  }
}

class _ConnectAccountPrompt extends StatelessWidget {
  final String serviceName;
  final String assetPath;
  final void Function()? onPressed;

  const _ConnectAccountPrompt({
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
