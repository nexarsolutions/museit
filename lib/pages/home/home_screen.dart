import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/health/health_support/health_support_screen.dart';

import '../profile/profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  onTap: (){
                    Get.to(()=>ProfileScreen());
                  },
                  child: const CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage('assets/images/profile_1.png'),
                  ),
                ),
                const SizedBox(width: 10),
                Text('Hi, Katherine!', style: manRopeSemiBold),
                const Spacer(),
                Container(
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
              ],
            ),
          ),

          // ===== Scroll Body =====
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // ==== Quote Box ====
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
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
                        child: buildSmallCard(
                          title: 'Create\nPlaylist',
                          image: 'assets/images/create_playlist.png',
                        ),
                      ),
                      const SizedBox(width: 29),
                      Expanded(
                        child: buildSmallCard(
                          title: 'Sent\nPlaylist',
                          image: 'assets/images/sent_playlist.png',
                        ),
                      ),
                      const SizedBox(width: 29),
                      Expanded(
                        child: buildSmallCard(
                          title: 'Send\nPlaylist',
                          image: 'assets/images/send_paid_songs.png',
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
                        child: buildFullWidthCard(
                          title: "Community",
                          image: "assets/images/community.png",
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: buildFullWidthCard(
                          title: "Health Support",
                          image: "assets/images/health_support.png",
                          onTap: () {
                            Get.to(() => const HealthSupportScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 23),
                Text('Recently Created Playlists',style: manRopeSemiBold.copyWith(fontSize: 14),)
              ],
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
        Positioned(top: -35, child: Image.asset(image, width: 70, height: 70)),
      ],
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
