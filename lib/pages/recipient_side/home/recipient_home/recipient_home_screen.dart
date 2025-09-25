import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/common_sections/notifications/notifications_screen.dart';
import 'package:musit/pages/sender_side/sender_home/sender_create_playlist/sender_create_playlist_bottom_sheet.dart';

import '../../../../common_widgets/saved_playlist_card.dart';
import '../../../sender_side/sent_playlist/view_sent_playlist/view_sent_playlist_screen.dart';
import '../../health_support/recipient_health_support/recipient_health_support_screen.dart';
import '../../recieved_playlist/recieved_playlist/recieved_playlist_screen.dart';
import '../../recieved_playlist/view_recieved_playlist/view_recieved_playlist_screen.dart';
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
          const SizedBox(height: 50),

          // ===== Top Profile Row =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => RecipientProfileScreen());
                  },
                  child: const CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage('assets/images/profile_1.png'),
                  ),
                ),
                const SizedBox(width: 10),
                Text('Hi, Katherine!', style: manRopeSemiBold),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(() => NotificationsScreen());
                  },
                  child: Container(
                    height: 44,
                    width: 44,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: blackColor,
                    ),
                    child: Image.asset(
                      'assets/images/notification.png',
                      scale: 4,
                    ),
                  ),
                ),
              ],
            ),
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
                  Container(
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
                  ),

                  const SizedBox(height: 53),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => RecievedPlaylistScreen());
                            },
                            child: buildSmallCard(
                              title: 'Received Playlist',
                              image: 'assets/images/recieved_playlist.png',
                            ),
                          ),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => RecievedSongsScreen());
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
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => RecipientCommunityScreen());

                            },
                            child: buildSmallCard(
                              title: "Community\n",
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
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => RecipientHealthSupportScreen());
                            },

                            child: buildSmallCard(
                              title: "Health Support",
                              image: "assets/images/health_support.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 23),
                  Text(
                    'New Playlist Received',
                    style: manRopeSemiBold.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 23),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    itemCount: controller.recentCardList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                            () => ViewRecievedPlaylistScreen(
                              showRecipients: false,
                              model: controller.recentCardList[index],
                            ),
                          );
                        },

                        child: SavedPlaylistCard(
                          showContainer: true,
                          showDateTime: true,
                          model: controller.recentCardList[index],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 23),
                ],
              ),
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
          constraints: BoxConstraints(maxHeight: 82, minHeight: 82),
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
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
        Positioned(top: -35, child: Image.asset(image, width: 70, height: 70)),
      ],
    );
  }

  // ===== Reusable Full Width Card =====
}
