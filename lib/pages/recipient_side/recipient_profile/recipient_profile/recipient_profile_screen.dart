import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/auth/login/login_screen.dart';
import 'package:musit/pages/common_sections/about_app/about_app_screen.dart';
import 'package:musit/pages/common_sections/privacy_policy/privacy_policy_screen.dart';
import 'package:musit/pages/common_sections/terms_conditions/terms_conditions_screen.dart';
import 'package:musit/pages/recipient_side/home/recipient_home/recipient_home_screen.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import '../../../../common_widgets/profile_widget.dart';
import '../../../select_role/select_role_screen.dart';
import '../../../sender_side/subscriptions/subscriptions/subscription_screen.dart';
import '../../saved_playlist/recipient_saved_playlist_screen.dart';
import '../recipient_change_password/recipient_change_password_bottomsheet.dart';
import '../recipient_edit_profile/recipient_edit_profile_screen.dart';
import '../recipient_history/recipient_history_screen.dart';
import '../recipient_saved_songs/recipient_saved_songs_screen.dart';

class RecipientProfileScreen extends StatelessWidget {
  const RecipientProfileScreen({super.key});

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
                  Get.offAll(()=>SelectRoleScreen());
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
                      Get.to(() => RecipientEditProfileScreen());
                    },
                  ),
                  ProfileWidget(
                    iconPath: 'assets/images/change_password.png',
                    title: 'Change Password',
                    onTap: () {
                      recipientChangePasswordBottomSheet();
                    },
                  ),
                  ProfileWidget(
                    iconPath: 'assets/images/saved_songs.png',
                    title: 'Saved Songs',
                    onTap: () {
                      Get.to(() => RecipientSavedSongsScreen());
                    },
                  ),
                  ProfileWidget(
                    iconPath: 'assets/images/saved_playlists.png',
                    title: 'Saved Playlists',
                    onTap: () {
                      Get.to(() => RecipientSavedPlaylistScreen());
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
                            Get.offAll(() => RecipientHomeScreen());
                          },
                        ),
                      );
                    },
                  ),
                  ProfileWidget(
                    iconPath: 'assets/images/purchase_history.png',
                    title: 'History',
                    onTap: () {
                      Get.to(() => RecipientHistoryScreen());
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
