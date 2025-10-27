import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';

import '../../../../common_widgets/saved_playlist_card.dart';
import '../../../../services/song_service.dart';
import '../../../../widgets/custom_header.dart';
import '../../../../widgets/error_widget_future_stream.dart';
import '../../../sender_side/sent_playlist/view_sent_playlist/view_sent_playlist_screen.dart';
import '../../recieved_playlist/recieved_playlist/recieved_playlist_screen.dart';
import '../../recieved_songs/recieved_songs/recieved_songs_screen.dart';
import '../../recipient_charity_compaign/recipient_charity_compaign/recipient_charity_compaign_screen.dart';
import '../../recipient_community/recipient_community/recipient_community_screen.dart';
import '../../recipient_profile/recipient_profile/recipient_profile_screen.dart';
import '../../saved_playlist/recipient_saved_playlist_screen.dart';
import 'controller/recipient_home_controller.dart';

class RecipientHomeScreen extends StatelessWidget {
  RecipientHomeScreen({super.key});

  final controller = Get.put(RecipientHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomHeader(
            onTap: () {
              Get.to(() => RecipientProfileScreen());
            },
          ),
          // ===== Scroll Body =====
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // ==== Quote Box ====
                  _buildQuoteBox(),

                  const SizedBox(height: 53),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        // Expanded(
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       Get.to(() => ReceivedPlaylistScreen());
                        //     },
                        //     child: buildSmallCard(
                        //       title: 'Received Playlist',
                        //       image: 'assets/images/recieved_playlist.png',
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(width: 25),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => ReceivedSongsScreen());
                            },
                            child: buildSmallCard(
                              title: 'Received Songs',
                              image: 'assets/images/recieved_songs.png',
                            ),
                          ),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => RecipientSavedPlaylistScreen());
                            },
                            child: buildSmallCard(
                              title: 'Saved Playlist',
                              image: 'assets/images/saved_playlist.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 53),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        // const SizedBox(width: 20),

                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => RecipientCommunityScreen());
                            },
                            child: buildSmallCard(
                              title: "Community",
                              image: "assets/images/community.png",
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => RecipientCharityCompaignScreen());
                            },
                            child: buildSmallCard(
                              title: 'Charity Campaign ',
                              image: 'assets/images/charity_compaign.png',
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Spacer(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 23),
                  // Text(
                  //   'New Playlist Received',
                  //   style: manRopeSemiBold.copyWith(fontSize: 14),
                  // ),
                  // const SizedBox(height: 23),
                  // FutureBuilder(
                  //     future: PlaylistService().getReceivedPlaylist(),
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
                  //                 // Get.to(
                  //                 //   () => ViewSentPlaylistScreen(
                  //                 //     playListId: playlist?.playlistId,
                  //                 //   ),
                  //                 // );
                  //               },
                  //               child: SavedPlaylistCard(
                  //                 showDateTime: true,
                  //                 playlist: playlist.playlist!,
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
      ),
    );
  }

  Container _buildQuoteBox() {
    return Container(
      width: Get.width,
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
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/left_comma.png',
                  height: 14,
                  width: 14,
                ),
                const SizedBox(height: 3),
                Text(
                  "Because everyone needs a soundtrack to rise, to heal, to fight, to feel alive again",
                  style: manRope.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    'assets/images/right_comma.png',
                    height: 14,
                    width: 14,
                  ),
                ),
              ],
            ),
          ),
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
  Widget buildSmallCard({required String title, required String image}) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          constraints: BoxConstraints(maxHeight: 84, minHeight: 84),
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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: manRopeSemiBold.copyWith(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Positioned(top: -35, child: Image.asset(image, width: 70, height: 70)),
      ],
    );
  }

// ===== Reusable Full Width Card =====
}
