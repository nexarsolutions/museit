import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/sendBottombar/controller/sender_bottom_bar_controller.dart';
import 'package:musit/pages/sendBottombar/sender_bottom_bar.dart';

import '../../../../../constants/app_enums.dart';
import '../../../../../globalModels/cart_model.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/web_view_screen.dart';
import '../../../../../widgets/youtube_player_widget.dart';

class ThankYouPage extends StatelessWidget {
  final RxList<CartModel> cartItems;

  const ThankYouPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: Get.height * 0.6,
        maxHeight: Get.height * 0.8,
      ),
      padding: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                child: Image.asset(
                  "assets/images/thank_you_page.jpeg",
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  height: Get.height * 0.35,
                )),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                "Your MUSEiT Moments are on there way!",
                style: manRopeSemiBold,
              ),
            ),
            SizedBox(height: 24,),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: CustomButton(
                  width: double.maxFinite,
                  onPressed: () {
                    Get.back();
                    Get.find<SenderBottomBarController>().selectedTab.value = 1;
                  },
                  text: "Send Another MUSEiT Moments"),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                "Share the love even futher",
                style: manRope,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
