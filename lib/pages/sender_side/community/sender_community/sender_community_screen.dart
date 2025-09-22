import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/charity_side/my_playlist/view_my_playlist/view_my_playlist_screen.dart';
import 'package:musit/pages/sender_side/community/sender_community/widget/sender_community_card.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_tab_button.dart';
import 'controller/sender_community_controller.dart';

class SenderCommunityScreen extends StatelessWidget {
  SenderCommunityScreen({super.key});
  final controller = Get.put(SenderCommunityController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Community', isBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Obx(
                    () => CustomTabButton(
                      tabNames: const [
                        'Motivational',
                        'Grief',
                        'Encourage',
                        'Love',
                      ],
                      selectedIndex: controller.selectedTab.value,
                      onTabSelected: (index) {
                        controller.selectedTab.value = index;
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 30),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          mainAxisExtent: 200,
                        ),
                    itemCount: controller.playlistList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                                  () => ViewMyPlaylistScreen(
                                    showRecipients: false,
                                model:  controller.playlistList[index],
                              ),
                            );
                          },
                          child: SenderCommunityCard(
                            model: controller.playlistList[index],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
