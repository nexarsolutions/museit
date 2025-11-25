import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';

import '../../../../widgets/custom_header.dart';
import '../../../../widgets/fade_text_carousel.dart';
import '../../recieved_songs/recieved_songs_screen.dart';
import '../../recipient_profile/recipient_profile/recipient_profile_screen.dart';
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // ==== Quote Box ====
                  _buildQuoteBox(),

                  Spacer(),
                  Row(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: _buildSmallCard(
                          title: 'Received Songs',
                          image: 'assets/images/recieved_songs.png',
                          primary: true,
                          onTap: () async {
                            Get.to(() => ReceivedSongsScreen());
                          },
                        ),
                      ),
                      Expanded(
                        child: _buildSmallCard(
                          title: "Community",
                          image: "assets/images/community.png",
                          primary: true,
                          onTap: () {
                            customErrorSnackBar(content: "Coming Soon");
                          },
                        ),
                      ),
                    ],
                  ),

                  Spacer(),
                  SizedBox(height: Get.height * 0.1),
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
