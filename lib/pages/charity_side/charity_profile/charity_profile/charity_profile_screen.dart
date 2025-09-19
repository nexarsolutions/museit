import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/privacy_policy/privacy_policy_screen.dart';
import 'package:musit/pages/terms_conditions/terms_conditions_screen.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../common_widgets/profile_widget.dart';
import '../../../about_app/about_app_screen.dart';
import '../charity_change_password/charity_change_password_bottomsheet.dart';
import '../charity_edit_profile/charity_edit_profile_screen.dart';
import '../edit_charity_profile/edit_charity_profile_screen.dart';

class CharityProfileScreen extends StatelessWidget {
  const CharityProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            text: 'Profile',
            isBack: true,
            showLastIcon: true,
            lastWidget: Container(
              height: 44,
              width: 44,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: blackColor,
              ),
              child: Image.asset('assets/images/logout_icon.png', scale: 3.5),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 145,
                      height: 145,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/dummy_profile.png'),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 12,
                            spreadRadius: 2,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Katherine James',
                    style: manRopeSemiBold.copyWith(fontSize: 14),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'abc@gmail.com',
                    style: manRope.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 52),
                  ProfileWidget(
                    iconPath: 'assets/images/edit_profile.png',
                    title: 'Edit Profile',
                    onTap: () {
                      Get.to(() => CharityEditProfileScreen());
                    },
                  ),
                  ProfileWidget(
                    iconPath: 'assets/images/change_password.png',
                    title: 'Change Password',
                    onTap: () {
                      charityChangePasswordBottomSheet();
                    },
                  ),
                  ProfileWidget(
                    iconPath: 'assets/images/edit_charity_profile.png',
                    title: 'Edit Charity Profile',
                    onTap: () {
                      Get.to(() => EditCharityProfileScreen());
                    },
                  ),
                  ProfileWidget(
                    iconPath: 'assets/images/privacy_policy.png',
                    title: 'Privacy Policy',
                    onTap: () {
                      Get.to(() => PrivacyPolicyScreen());

                    },
                  ),
                  ProfileWidget(
                    iconPath: 'assets/images/terms_conditions.png',
                    title: 'Terms & Conditions',
                    onTap: () {
                      Get.to(() => TermsConditionsScreen());

                    },
                  ),
                  ProfileWidget(
                    iconPath: 'assets/images/about.png',
                    title: 'About',
                    onTap: () {
                      Get.to(() => AboutAppScreen());

                    },
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
