import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/utils/extensions.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../common_widgets/profile_widget.dart';
import '../../../../main.dart';
import '../../../../utils/dialog_utilities.dart';
import '../../../auth/login/login_screen.dart';
import '../../../common_sections/about_app/about_app_screen.dart';
import '../../../common_sections/privacy_policy/privacy_policy_screen.dart';
import '../../../common_sections/terms_conditions/terms_conditions_screen.dart';
import '../../../sender_side/profile/change_password/change_password_bottomsheet.dart';
import '../../../sender_side/profile/edit_profile/edit_profile_screen.dart';
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
              child: GestureDetector(
                onTap: () {
                  confirmationDialog(
                    title: "Logout",
                    content: "Are you sure to "
                        "logout?",
                    onConfirm: () async {
                      loadingDialog();

                      await userManager.clearUser();
                      Get.back(); //close loading dialog
                      Get.offAll(() => LoginScreen());
                    },
                  );
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
                  Obx(
                    () {
                      final image = userManager.cachedUser?.profile.value ?? '';
                      final name =
                          userManager.cachedUser?.username.value.text ?? '';
                      final email =
                          userManager.cachedUser?.email.value.text ?? '';
                      return Column(
                        children: [
                          Center(
                            child: Container(
                              width: 145,
                              height: 145,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 12,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: image != ''
                                    ? Image(
                                        image: CachedNetworkImageProvider(
                                          image.showImage,
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        color: greyColor,
                                        child: Center(
                                          child: Text(
                                            name != ''
                                                ? name
                                                    .trim()
                                                    .split('')
                                                    .first
                                                    .toUpperCase()
                                                : '?',
                                            style: manRopeSemiBold.copyWith(
                                              color: whiteColor,
                                              fontSize:
                                                  50, // proportional to 145px size
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            name.withNa,
                            style: manRopeSemiBold.copyWith(fontSize: 14),
                          ),
                          SizedBox(height: 3),
                          Text(
                            email.withNa,
                            style: manRope.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      );
                    },
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
//yudrakokno@necub.com
