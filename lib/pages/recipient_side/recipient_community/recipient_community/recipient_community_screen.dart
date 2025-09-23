import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/sender_side/community/sender_community/widget/sender_community_card.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_tab_button.dart';
import '../recipient_view_community/recipient_view_community_screen.dart';
import 'controller/recipient_community_controller.dart';

class RecipientCommunityScreen extends StatelessWidget {
  RecipientCommunityScreen({super.key});
  final controller = Get.put(RecipientCommunityController());
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
                  Obx(
                    () => GridView.builder(
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
                      itemCount: controller.selectedTab.value == 0
                          ? controller.motivationalList.length
                          : controller.selectedTab.value == 1
                          ? controller.griefList.length
                          : controller.selectedTab.value == 2
                          ? controller.encourageList.length
                          : controller.loveList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => RecipientViewCommunityScreen(
                                  showRecipients: false,
                                  model: controller.selectedTab.value == 0
                                      ? controller.motivationalList[index]
                                      : controller.selectedTab.value == 1
                                      ? controller.griefList[index]
                                      : controller.selectedTab.value == 2
                                      ? controller.encourageList[index]
                                      : controller.loveList[index],
                                ),
                              );
                            },
                            child: SenderCommunityCard(
                              model: controller.selectedTab.value == 0
                                  ? controller.motivationalList[index]
                                  : controller.selectedTab.value == 1
                                  ? controller.griefList[index]
                                  : controller.selectedTab.value == 2
                                  ? controller.encourageList[index]
                                  : controller.loveList[index],
                            ),
                          ),
                        );
                      },
                    ),
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
