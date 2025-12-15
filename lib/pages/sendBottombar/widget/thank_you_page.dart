import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/sendBottombar/controller/sender_bottom_bar_controller.dart';

import '../../../../../globalModels/cart_model.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../constants/colors.dart';

class ThankYouPage extends StatelessWidget {
  const ThankYouPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: true,
        top: true,
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/thank_you_page.jpg"),
              fit: BoxFit.fitHeight,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            spacing: 16,
            children: [
              // Image.asset(
              //   "assets/images/thank_you_page.jpeg",
              //   fit: BoxFit.fitWidth,
              //   width: double.infinity,
              //   height: Get.height * 0.35,
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(blackColor),
                        foregroundColor: WidgetStatePropertyAll(whiteColor),
                      ),
                      icon: Icon(
                        Icons.close,
                      )),
                ),
              ),
              Spacer(),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  "Your MUSEiT Moments are on there way!",
                  style: manRopeSemiBold.copyWith(color: whiteColor),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: CustomButton(
                    width: double.maxFinite,
                    onPressed: () {
                      Get.back();
                      Get.find<SenderBottomBarController>().selectedTab.value =
                          1;
                    },
                    text: "Send Another MUSEiT Moments"),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  "Share the love even futher",
                  style: manRope.copyWith(color: whiteColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
