import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/pages/auth/signup/signup_screen.dart';
import 'package:musit/widgets/custom_button.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/select_role_background.png',
                  height: Get.height * 0.4,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                    height: Get.height * 0.15,
                    decoration: BoxDecoration(
                      // Corrected the gradient direction and colors
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(
                            0.0,
                          ), // Starts fully transparent
                          Colors.white, // Fades to solid white
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 23),
            Text('Select Account Type', style: manRopeSemiBold),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                'Motivation moves in two ways, will you send it or receive it?',
                style: manRopeSemiBold.copyWith(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            // SizedBox(height: 24),
            Spacer(),
            CustomButton(
              onPressed: () {
                Get.to(() => SignupScreen(roleId: 1));
              },
              text: 'MUSE',
            ),
            SizedBox(height: 16),
            CustomButton(
              onPressed: () {
                Get.to(() => SignupScreen(roleId: 2));
              },
              text: 'Charity.',
              backgroundColor: whiteColor,
              borderColor: blackColor,
              isBorder: true,
              borderWidth: 1,
              textColor: blackColor,
            ),
            SizedBox(height: 12),
            Center(
              child: Text(
                'or',
                style: manRope.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style:
                      manRopeSemiBold.copyWith(fontSize: 14, color: blackColor),
                  children: [
                    TextSpan(
                      text: 'continue as ',
                      style: manRope,
                    ),
                    TextSpan(
                      text: 'Charity Organization',
                      style: manRope.copyWith(
                          fontWeight: FontWeight.w600, color: greenColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => SignupScreen(roleId: 3)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
