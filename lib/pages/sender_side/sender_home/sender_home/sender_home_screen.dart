import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/common_sections/notifications/notifications_screen.dart';
import 'package:musit/pages/sender_side/send_playlist/paid_songs_recipient/paid_songs_recipient_screen.dart';
import 'package:musit/pages/sender_side/sender_home/sender_add_songs/sender_add_songs_screen.dart';
import 'package:musit/pages/sender_side/sender_home/sender_create_playlist/sender_create_playlist_bottom_sheet.dart';
import 'package:musit/services/paylist_service.dart';
import 'package:musit/widgets/error_widget_future_stream.dart';

import '../../../../common_widgets/saved_playlist_card.dart';
import '../../../../widgets/custom_header.dart';
import '../../../charity_side/my_playlist/view_my_playlist/view_my_playlist_screen.dart';
import '../../community/sender_community/sender_community_screen.dart';
import '../../community/sender_view_community/sender_view_community_screen.dart';
import '../../health/health_support/health_support_screen.dart';
import '../../profile/profile/profile_screen.dart';
import '../../send_playlist/sender_send_playlist/sender_send_playlist_screen.dart';
import '../../sender_send_song/add_songs/add_songs_screen.dart';
import '../../sender_send_song/sender_send_song/sender_send_song_screen.dart';
import '../../sent_playlist/sender_sent_playlist/sender_sent_playlist_screen.dart';
import '../../sent_playlist/view_sent_playlist/view_sent_playlist_screen.dart';
import 'controller/sender_home_controller.dart';

class SenderHomeScreen extends StatelessWidget {
  SenderHomeScreen({super.key});

  final controller = Get.put(SenderHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          // ===== Top Profile Row =====
          CustomHeader(),

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
                        _buildSmallCard(
                          title: 'Create Playlist',
                          image: 'assets/images/create_playlist.png',
                          onTap: () {
                            senderCreatePlaylistBottomSheet();
                          },
                        ),
                        const SizedBox(width: 19),
                        _buildSmallCard(
                          title: 'Sent Playlist',
                          image: 'assets/images/sent_playlist.png',
                          onTap: () {
                            Get.to(() => SenderSentPlaylistScreen());
                          },
                        ),
                        const SizedBox(width: 19),
                        _buildSmallCard(
                          title: 'Send a MUSE',
                          image: 'assets/images/send_paid_songs.png',
                          onTap: () {
                            Get.to(() => SenderSendPlaylistScreen());
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 53),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        _buildSmallCard(
                          title: 'Send Song',
                          image: 'assets/images/send_paid_songs.png',
                          onTap: () {
                            Get.to(() => AddSongsScreen());
                          },
                        ),
                        const SizedBox(width: 19),
                        _buildSmallCard(
                          title: "Community",
                          image: "assets/images/community.png",
                          onTap: () {
                            Get.to(() => SenderCommunityScreen());
                          },
                        ),
                        const SizedBox(width: 19),
                        _buildSmallCard(
                          title: "Health Support",
                          image: "assets/images/health_support.png",
                          onTap: () {
                            Get.to(() => const HealthSupportScreen());
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 23),
                  Text(
                    'Recently Created Playlists',
                    style: manRopeSemiBold.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 23),
                  FutureBuilder(
                      future: PlaylistService().getPlayList(),
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
                          return const ErrorWidgetFutureStream(
                            error: 'No Data Found',
                          );
                        }

                        final playLists = snapshot.requireData;

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          primary: false,
                          shrinkWrap: true,
                          itemCount: playLists.length,
                          itemBuilder: (context, index) {
                            final playlist = playLists[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => ViewSentPlaylistScreen(
                                      playListId: playlist.id,
                                    ),
                                  );
                                },
                                child: SavedPlaylistCard(
                                  showDateTime: true,
                                  playlist: playlist,
                                ),
                              ),
                            );
                          },
                        );
                      }),
                  const SizedBox(height: 23),
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
  Widget _buildSmallCard(
      {required String title, required String image, void Function()? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
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
                    style: manRopeSemiBold.copyWith(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Positioned(
                top: -35, child: Image.asset(image, width: 70, height: 70)),
          ],
        ),
      ),
    );
  }

  // ===== Reusable Full Width Card =====
  Widget buildFullWidthCard({
    required String title,
    required String image,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: Get.width,
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
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
                Text(title, style: manRopeSemiBold.copyWith(fontSize: 10)),
              ],
            ),
          ),
          Positioned(
            top: -35,
            child: Image.asset(image, width: 70, height: 70),
          ),
        ],
      ),
    );
  }
}
