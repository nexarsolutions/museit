import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/main.dart';
import 'package:musit/pages/sendBottombar/controller/sender_bottom_bar_controller.dart';
import 'package:musit/pages/sender_side/sender_send_song/voice_note/voice_note_screen.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/widgets/custom_button.dart';

import '../../../../utils/dialog_utilities.dart';
import '../../../../widgets/custom_header.dart';
import '../../../../widgets/fade_text_carousel.dart';
import '../../community/sender_community/sender_community_screen.dart';
import '../../sender_send_song/add_songs/add_songs_screen.dart';
import '../../sent_playlist/sentSongs/sent_songs_screen.dart';

class SenderHomeScreen extends StatelessWidget {
  const SenderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ===== Top Profile Row =====
        CustomHeader(),

        // ===== Scroll Body =====
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                // const SizedBox(height: 20),

                // ==== Quote Box ====
                _buildQuoteBox(),
                Spacer(),

                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: _buildSmallCard(
                        title: 'MUSEiT Moment',
                        image: 'assets/images/send_paid_songs.png',
                        primary: true,
                        onTap: () async {
                          // Get.to(()=>VoiceNoteScreen(isFromMuseitMoment: true));
                          Get.find<SenderBottomBarController>()
                              .selectedTab
                              .value = 1;
                          // // Get.to(() => AddSongsScreen());
                          if (userManager.isFirstTimeAddSongScreen) {
                            successDialog(
                                content:
                                """A MUSEiT Moment is 1 message + 1 song sent to your favourite people.\nEvery MUSEiT Moment sent, 50p will go towards your selected charity.""");
                            await userManager.saveFirstTimeAddSongScreen();
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: _buildSmallCard(
                        title: 'MUSEiT\nBundle',
                        image: 'assets/images/send_paid_songs.png',
                        primary: true,
                        onTap: () {
                          customErrorSnackBar(content: "“Coming Soon");
                        },
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Center(
                  child: CustomButton(
                      onPressed: () {
                        customErrorSnackBar(content: "“Coming Soon");
                      },
                      text: ' MUSEiT Charity'),
                ),
                Spacer(),

                // const SizedBox(height: 53),

                // Row(
                //   spacing: 19,
                //   children: [
                //     _buildSmallCard(
                //       title: 'MUSEiT Moment',
                //       image: 'assets/images/send_paid_songs.png',
                //       onTap: () {
                //         Get.find<SenderBottomBarController>()
                //             .selectedTab
                //             .value = 1;
                //         // Get.to(() => AddSongsScreen());
                //       },
                //     ),
                //     _buildSmallCard(
                //       title: "Community",
                //       image: "assets/images/community.png",
                //       onTap: () {
                //         Get.to(() => SenderCommunityScreen());
                //       },
                //     ),
                //     _buildSmallCard(
                //       title: 'Sent Songs',
                //       image: 'assets/images/sent_playlist.png',
                //       onTap: () {
                //         Get.to(() => SentSongsScreen());
                //       },
                //     ),
                //   ],
                // ),
                // Row(
                //   spacing: 19,
                //   children: [
                //     // _buildSmallCard(
                //     //   title: 'Create Playlist',
                //     //   image: 'assets/images/create_playlist.png',
                //     //   onTap: () {
                //     //     senderCreatePlaylistBottomSheet();
                //     //   },
                //     // ),
                //     // const SizedBox(width: 19),
                //     // _buildSmallCard(
                //     //   title: 'Sent Playlist',
                //     //   image: 'assets/images/sent_playlist.png',
                //     //   onTap: () {
                //     //     Get.to(() => SenderSentPlaylistScreen());
                //     //   },
                //     // ),
                //     // const SizedBox(width: 19),
                //
                //   ],
                // ),

                // const SizedBox(height: 53),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 24.0),
                //   child: Row(
                //     children: [
                //       // _buildSmallCard(
                //       //   title: 'Send Song',
                //       //   image: 'assets/images/send_paid_songs.png',
                //       //   onTap: () {
                //       //     Get.to(() => AddSongsScreen());
                //       //   },
                //       // ),
                //       // const SizedBox(width: 19),
                //       // _buildSmallCard(
                //       //   title: "Community",
                //       //   image: "assets/images/community.png",
                //       //   onTap: () {
                //       //     Get.to(() => SenderCommunityScreen());
                //       //   },
                //       // ),
                //     ],
                //   ),
                // ),

                // const SizedBox(height: 23),
                // Text(
                //   'Recently Created Playlists',
                //   style: manRopeSemiBold.copyWith(fontSize: 14),
                // ),
                // const SizedBox(height: 23),
                // FutureBuilder(
                //     future: PlaylistService().getPlayList(),
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState ==
                //           ConnectionState.waiting) {
                //         return ErrorWidgetFutureStream();
                //       }
                //
                //       if (snapshot.hasError) {
                //         return ErrorWidgetFutureStream(
                //           error: snapshot.error.toString(),
                //         );
                //       }
                //
                //       if (!snapshot.hasData ||
                //           snapshot.data == null ||
                //           snapshot.data!.isEmpty) {
                //         return const ErrorWidgetFutureStream(
                //           error: 'No Data Found',
                //         );
                //       }
                //
                //       final playLists = snapshot.requireData;
                //
                //       return ListView.builder(
                //         padding: EdgeInsets.zero,
                //         physics: NeverScrollableScrollPhysics(),
                //         primary: false,
                //         shrinkWrap: true,
                //         itemCount: playLists.length,
                //         itemBuilder: (context, index) {
                //           final playlist = playLists[index];
                //
                //           return Padding(
                //             padding: const EdgeInsets.only(bottom: 30.0),
                //             child: GestureDetector(
                //               onTap: () {
                //                 Get.to(
                //                   () => ViewSentPlaylistScreen(
                //                     playListId: playlist.id,
                //                   ),
                //                 );
                //               },
                //               child: SavedPlaylistCard(
                //                 showDateTime: true,
                //                 playlist: playlist,
                //               ),
                //             ),
                //           );
                //         },
                //       );
                //     }),
                // const SizedBox(height: 23),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container _buildQuoteBox() {
    return Container(
      width: Get.width,
      height: 110,
      padding: const EdgeInsets.only(
        left: 16,
        top: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: lightWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: darkGrey.withOpacity(0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeTextCarousel(),
          const SizedBox(width: 20),
          Expanded(
            child: Image.asset(
              'assets/images/music_waves.png',
              height: 64,
              width: Get.width,
            ),
          ),
        ],
      ),
    );
  }

  // ===== Reusable Small Card =====
  Widget _buildSmallCard({
    required String title,
    required String image,
    void Function()? onTap,
    bool primary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: (Get.width - 32 /*- 19 - 19*/) / (primary ? 2 : 3),
              constraints: BoxConstraints(
                  maxHeight: primary ? 126 : 84,
                  minHeight: primary ? 126 : 84,
                  maxWidth: (Get.width - 32 /*- 19 - 19*/) / (primary ? 2 : 3)),
              padding: const EdgeInsets.only(
                left: 18,
                right: 18,
                top: 41,
                bottom: 13,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF8C7FAC).withOpacity(0.15),
                    const Color(0xFF7695CA).withOpacity(0.15),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: darkGrey.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    style:
                        manRopeSemiBold.copyWith(fontSize: primary ? 18 : 10),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Positioned(
                top: primary ? -60 : -35,
                child: Image.asset(image,
                    width: primary ? 100 : 70, height: primary ? 100 : 70)),
          ],
        ),
      ),
    );
  }
}
