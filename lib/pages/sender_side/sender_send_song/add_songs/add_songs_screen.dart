import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/charity_side/charity_home/charity_add_songs/widget/add_songs_widget.dart';
import 'package:musit/pages/music_player/music_player_screen.dart';
import 'package:musit/pages/sender_side/sender_send_song/add_songs/widget/build_youtube_widget.dart';
import 'package:musit/pages/sender_side/sender_send_song/add_songs/widget/connect_account_prompt.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_button.dart';
import 'package:musit/widgets/custom_text_field.dart';
import 'package:musit/widgets/error_widget_future_stream.dart';

import '../../../../globalModels/song_model.dart';
import '../../../../services/spotify_auth_service.dart';
import '../../../../widgets/custom_tab_button.dart';
import '../../../viewCharityOrg/view_charity_organization.dart';
import '../../sender_home/sender_view_recipient/sender_view_recipient_screen.dart';
import '../../sender_home/sender_view_recipient/widget/send_via_phone_sheet.dart';
import 'controller/add_songs_controller.dart';
import 'widget/build_spotify_widget.dart';

class AddSongsScreen extends StatelessWidget {
  AddSongsScreen({super.key, required this.voiceSongs});

  final controller = Get.put(AddSongsController());
  final SpotifyAuthService spotifyService = Get.find<SpotifyAuthService>();
  final List<SongModel> voiceSongs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          children: [
            CustomAppBar(text: 'MUSEiT Moment', isBack: true),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomTextField(
                borderRadius: 50,
                controller: controller.searchController,
                hintText: 'Search songs',
                onChanged: (value) {
                  controller.searchQuery.value = value.trim();
                  if (value.trim().isEmpty) {
                    controller.searchQuery.value = '';
                  } else {
                    controller.searchQuery.value = value;
                  }

                  // if (controller.songTypeId.value == 1 &&
                  //     value.trim().isNotEmpty) {
                  //   controller.searchInYoutubeList.value =
                  //       RxList<Map<String, String>>.from(controller
                  //           .youtubeSongsList
                  //           .where((value) => value['name']!
                  //               .toLowerCase()
                  //               .contains(controller.searchQuery.value
                  //                   .toLowerCase())));
                  // }
                },
                isSuffixIcon: true,
                suffixIcon: Container(
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
                        selectedColor: Color(0xFF1db954)),
                    TabItem(
                        title: "Youtube",
                        selectedIcon: 'assets/images/youtube_selected.png',
                        unselectedIcon: 'assets/images/youtube.png',
                        selectedColor: Color(0xFFFF0000)),
                    TabItem(
                        title: "Apple",
                        selectedIcon: 'assets/images/selected_apple_music.png',
                        unselectedIcon:
                            'assets/images/unselected_apple_music.png',
                        selectedColor: Color(0xFFFF4E6B)),
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
                              ? BuildSpotifyWidget(
                                  controller: controller,
                                )
                              : ConnectAccountPrompt(
                                  serviceName: 'Spotify',
                                  assetPath:
                                      'assets/images/spotify_selected.png',
                                  // onPressed: spotifyService.connectSpotify,
                                  onPressed: () {
                                    customErrorSnackBar(content: "Coming soon");
                                  },
                                );
                        })
                      : controller.songTypeId.value == 1
                          ? BuildYoutubeWidget(controller: controller)
                          : controller.songTypeId.value == 2
                              ? ConnectAccountPrompt(
                                  serviceName: 'Apple Music',
                                  assetPath:
                                      'assets/images/selected_apple_music.png',
                                  onPressed: null,
                                )
                              : Obx(
                                  () => FutureBuilder(
                                      key: ValueKey(
                                          controller.searchQuery.value),
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
                                                        controller.songs
                                                            .clear();
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
                        /// navigat to send view screen
                        Get.to(() => SenderViewRecipientScreen(
                              rowWidget: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showSendViaPhoneSheet(
                                        context: Get.context!,
                                        onPhoneSubmitted: (phone) {
                                          controller.shareMomentExternally(
                                              controller.songs, 'WhatsApp',
                                              receiver: phone);
                                        },
                                      );
                                    },
                                    icon: Image.asset(
                                      "assets/images/whatsapp.png",
                                      width: 35, height: 35,
                                      // color: Colors.green
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showSendViaPhoneSheet(
                                        context: Get.context!,
                                        isEmail: true,
                                        onPhoneSubmitted: (phone) {
                                          controller.shareMomentExternally(
                                              controller.songs, 'Email',
                                              receiver: phone);
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.email,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                              onPressedSave:
                                  (List<int> selectedUser, String? phone) {
                                if (selectedUser.isEmpty && phone == null) {
                                  customErrorSnackBar(
                                      content:
                                          "Select Users or enter phone number to continue");
                                  return;
                                }
                                controller.shareSong(
                                    voiceSongs, phone, selectedUser);
                              },
                            ));
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
      ),
    );
  }
}
