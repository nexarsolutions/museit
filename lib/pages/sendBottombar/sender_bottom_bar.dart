import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';

import 'controller/sender_bottom_bar_controller.dart';

class SenderBottomBar extends StatelessWidget {
  SenderBottomBar({super.key});

  final controller = Get.put(SenderBottomBarController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Obx(
          () => SenderBottomBarController.widgets
              .elementAt(controller.selectedTab.value),
        ),
        bottomNavigationBar: Container(
          height: 62,
          decoration: BoxDecoration(
            color: lightWhite,
            borderRadius: BorderRadius.circular(50),
          ),
          padding:
              const EdgeInsets.only(top: 1, left: 25, right: 25, bottom: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _navSelectedWidget(
                  activeIcon: 'assets/images/home_active.png',
                  inActiveIcon: 'assets/images/home_inactive.png',
                  text: 'Home',
                  index: 0),
              _navSelectedWidget(
                  activeIcon: 'assets/images/museit_active.png',
                  inActiveIcon: 'assets/images/museit_inactive.png',
                  text: 'MUSEiT',
                  index: 1),
              _navSelectedWidget(
                  activeIcon: 'assets/images/community_active.png',
                  inActiveIcon: 'assets/images/community_inactive.png',
                  text: 'Community',
                  index: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navSelectedWidget({
    required String activeIcon,
    required String inActiveIcon,
    required String text,
    required int index,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () => controller.selectedTab.value = index,
      child: Obx(() {
        bool isSelected = controller.selectedTab.value == index;
        return SizedBox(
          width: 60,
          height: 60,
          child: Column(
            children: [
              if (isSelected)
                Container(
                  width: double.infinity,
                  height: 2,
                  color: blackColor,
                ),
              const Spacer(),
              Image.asset(
                isSelected ? activeIcon : inActiveIcon,
                height: 24,
                color: !isSelected ? Colors.black54 : Colors.black,
                width: 24,
                // color: isSelected ? blackColor : null,
              ),
              const Spacer(),
              if (isSelected)
                Text(
                  text,
                  style: manRopeSemiBold.copyWith(
                    color: blackColor,
                    fontSize: 10,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
