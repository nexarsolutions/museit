import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/auth/login/login_screen.dart';
import 'package:musit/pages/common_sections/about_app/about_app_screen.dart';
import 'package:musit/pages/common_sections/privacy_policy/privacy_policy_screen.dart';
import 'package:musit/pages/common_sections/terms_conditions/terms_conditions_screen.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../common_widgets/profile_widget.dart';
import '../../sender_home/sender_home/sender_home_screen.dart';
import '../../subscriptions/subscriptions/subscription_screen.dart';
import '../change_password/change_password_bottomsheet.dart';
import '../edit_profile/edit_profile_screen.dart';
import '../purchase_history/purchase_history_screen.dart';
import '../saved_playlist/saved_playlist_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
              child: GestureDetector(
                onTap: (){
                  Get.offAll(()=>LoginScreen(isSender: true));
                },
                child: Image.asset('assets/images/logout_icon.png', scale: 3.5),
              ),
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
                      Get.to(() => EditProfileScreen());
                    },
                  ),
                  ProfileWidget(
                    iconPath: 'assets/images/change_password.png',
                    title: 'Change Password',
                    onTap: () {
                      changePasswordBottomSheet();
                    },
                  ),
                  ProfileWidget(
                    iconPath: 'assets/images/subscriptions.png',
                    title: 'Subscriptions',
                    onTap: () {
                      Get.to(
                        () => SubscriptionScreen(
                          iSender: true,
                          isBack: true,
                          paymentConfirmOnTap: () {
                            Get.offAll(() => SenderHomeScreen());
                          },
                        ),
                      );
                    },
                  ),
                  ProfileWidget(
                    iconPath: 'assets/images/purchase_history.png',
                    title: 'Purchase History',
                    onTap: () {
                      Get.to(() => PurchaseHistoryScreen());
                    },
                  ),
                  ProfileWidget(
                    iconPath: 'assets/images/saved_playlists.png',
                    title: 'Saved Playlists',
                    onTap: () {
                      Get.to(() => SavedPlaylistScreen());
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
