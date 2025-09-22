import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/common_widgets/my_compaigns_widget.dart';
import 'package:musit/constants/colors.dart';
import '../../../../constants/text_styles.dart';
import '../../../common_sections/notifications/notifications_screen.dart';
import '../../charity_create_compaign/charity_create_compaign_screen.dart';
import '../../charity_create_playlist/charity_create_playlist_bottomsheet.dart';
import '../../charity_profile/charity_profile/charity_profile_screen.dart';
import '../../my_playlist/charity_my_playlist/charity_my_playlist_screen.dart';
import '../my_compaigns/my_compaigns_screen.dart';
import '../view_my_compaigns/view_my_compaigns_screen.dart';
import 'controller/charity_home_controller.dart';

class CharityHomeScreen extends StatelessWidget {
   CharityHomeScreen({super.key});
final controller = Get.put(CharityHomeController());
  @override
  Widget build(BuildContext context) {
    // Local function to build a reusable metric card widget

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
                    Get.to(()=>CharityProfileScreen());
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
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  buildMetricCard(
                    imagePath: 'assets/images/charity.png',
                    title: 'Total Donations',
                    value: '\$5651',
                  ),
                  const SizedBox(height: 10),
                  buildMetricCard(
                    imagePath: 'assets/images/donations.png',
                    title: 'Active Campaigns',
                    value: '\$5651',
                  ),
                  const SizedBox(height: 49),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Get.to(()=>CharityCreateCompaignScreen());
                            },
                            child: buildSmallCard(
                              title: 'Create Charity\nCampaign ',
                              image: 'assets/images/create_charity_compaign.png',
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),

                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              charityCreatePlaylistBottomSheet();
                            },
                            child: buildSmallCard(
                              title: 'Create\nPlaylist',
                              image: 'assets/images/create_playlist.png',
                            ),
                          ),
                        ),

                        const SizedBox(width: 20),
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Get.to(()=>CharityMyPlaylistScreen());
                            },
                            child: buildSmallCard(
                              title: 'My\nPlaylists',
                              image: 'assets/images/my_playlists.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>MyCompaignsScreen());
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'My Compaigns',
                            style: manRopeSemiBold.copyWith(fontSize: 14),
                          ),
                        ),
                        Text(
                          'View all',
                          style: manRopeSemiBold.copyWith(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            decorationColor: blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(

                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 30),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      mainAxisExtent: 190,
                    ),
                    itemCount: controller.myCompaignsList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                                () => ViewMyCompaignsScreen(
                              model: controller.myCompaignsList[index],
                            ),
                          );
                        },
                        child: MyCompaignsWidget(
                          model: controller.myCompaignsList[index],
                        ),
                      );
                    },
                  ),
                  // const SizedBox(height: /),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMetricCard({
    required String imagePath,
    required String title,
    required String value,
  }) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8C7FAC).withOpacity(0.15),
            const Color(0xFF7695CA).withOpacity(0.15),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: blackColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Image.asset(imagePath, scale: 3.2),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: manRopeSemiBold.copyWith(
                      fontSize: 14,
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 23),
          Text(
            value,
            style: manRopeSemiBold.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 23),
          const SizedBox(height: 23),
        ],
      ),
    );
  }

  Widget buildSmallCard({required String title, required String image}) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 100,
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
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
}
