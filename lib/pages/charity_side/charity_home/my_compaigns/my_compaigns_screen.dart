import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/charity_side/charity_create_compaign/charity_create_compaign_screen.dart';
import 'package:musit/pages/charity_side/charity_home/my_compaigns/controller/my_compaigns_controller.dart';
import 'package:musit/pages/charity_side/charity_home/view_my_compaigns/view_my_compaigns_screen.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_tab_button.dart';

import '../../../../common_widgets/my_compaigns_widget.dart';

class MyCompaignsScreen extends StatelessWidget {
  MyCompaignsScreen({super.key});

  final controller = Get.put(MyCompaignsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            text: 'My Compaigns',
            isBack: true,
            showLastIcon: true,
            lastWidget: GestureDetector(
              onTap: () {
                Get.to(() => CharityCreateCompaignScreen());
              },
              child: Image.asset(
                'assets/images/add_icon_rounded.png',
                height: 44,
                width: 44,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Obx(
                    () => CustomTabButton(
                      tabNames: const ['Active', 'Pause', 'Draft', 'Completed'],
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
                            mainAxisExtent: 190,
                          ),
                      itemCount: controller.selectedTab.value == 0
                          ? controller.activeCompaignsList.length
                          : controller.selectedTab.value == 1
                          ? controller.pauseCompaignsList.length
                          : controller.selectedTab.value == 2
                          ? controller.draftsList.length
                          : controller.completedList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => ViewMyCompaignsScreen(
                                  model: controller.selectedTab.value == 0
                                      ? controller.activeCompaignsList[index]
                                      : controller.selectedTab.value == 1
                                      ? controller.pauseCompaignsList[index]
                                      : controller.selectedTab.value == 2
                                      ? controller.draftsList[index]
                                      : controller.completedList[index],
                                ),
                              );
                            },
                            child: MyCompaignsWidget(
                              model: controller.selectedTab.value == 0
                                  ? controller.activeCompaignsList[index]
                                  : controller.selectedTab.value == 1
                                  ? controller.pauseCompaignsList[index]
                                  : controller.selectedTab.value == 2
                                  ? controller.draftsList[index]
                                  : controller.completedList[index],
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
