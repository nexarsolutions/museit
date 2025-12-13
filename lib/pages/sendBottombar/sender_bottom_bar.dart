import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/main.dart';
import 'package:musit/pages/sendBottombar/widget/thank_you_page.dart';
import 'package:musit/utils/dialog_utilities.dart';

import '../sender_side/sender_home/preSavedRecipients/widget/view_cart.dart';
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
        floatingActionButton: SizedBox(
          height: 70,
          width: 80,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.white,
            onPressed: () {
              Get.bottomSheet(
                SafeArea(
                    child:
                        CartListBottomSheet(cartItems: userManager.cartItems)),
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
              );
            },
            label: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_basket_sharp,
                ),
                Text("View Cart ")
              ],
            ),
          ),
        ),
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
      onTap: () async {
        controller.selectedTab.value = index;
        if (index == 1 && userManager.isFirstTimeAddSongScreen) {
          successDialog(
              content:
                  """A MUSEiT Moment is 1 message + 1 song sent to your favourite people.\nEvery MUSEiT Moment sent, 50p will go towards your selected charity.""");
          await userManager.saveFirstTimeAddSongScreen();
        }
      },
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
