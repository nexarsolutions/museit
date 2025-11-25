import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/main.dart';
import 'package:musit/services/auth_service.dart';
import 'package:musit/utils/extensions.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../pages/sender_side/profile/profile/profile_screen.dart';

class CustomHeader extends StatelessWidget {
  CustomHeader({super.key, this.onTap});

  final void Function()? onTap;
  final RxBool switchValue = false.obs;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final image = userManager.cachedUser?.profile.value ?? '';
      final name = userManager.cachedUser?.username.value.text ?? '';
      return Padding(
        padding:
            const EdgeInsets.only(left: 16.0, right: 16, top: 50, bottom: 16),
        child: Row(
          spacing: 10,
          children: [
            GestureDetector(
              onTap: onTap ??
                  () {
                    Get.to(() => ProfileScreen());
                  },
              child: CircleAvatar(
                radius: 22,
                backgroundColor: greyColor,
                backgroundImage: image != ''
                    ? CachedNetworkImageProvider(
                        userManager.cachedUser!.profile.value.showImage)
                    : null,
                child: image != ''
                    ? null
                    : Center(
                        child: Text(
                          name != '' ? name.split('').first.toUpperCase() : '?',
                          style: manRopeSemiBold.copyWith(
                            color: whiteColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
              ),
            ),
            Expanded(
                child: Text('Hi, ${name.withNa}!', style: manRopeSemiBold)),
            Text(
              userManager.cachedUser?.currentRoleId == 1
                  ? 'Receiver'
                  : 'Sender',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold, color: blackColor),
            ),
            SizedBox(
              width: 44,
              child: userManager.cachedUser?.currentRoleId == null
                  ? const SizedBox.shrink()
                  : userManager.cachedUser?.currentRoleId == 3
                      ? const SizedBox.shrink()
                      : Obx(() => Switch(
                            value: switchValue.value,
                            inactiveThumbColor: blackColor,
                            inactiveTrackColor: blueColor,
                            onChanged: (value) async {
                              if (value = true) {
                                bool roleAvailable = userManager
                                        .cachedUser?.availableRoles
                                        .contains(userManager.cachedUser!
                                                    .currentRoleId ==
                                                1
                                            ? 2
                                            : 1) ??
                                    false;

                                if (roleAvailable) {
                                  await AuthService().switchRole(
                                      roleId: userManager
                                                  .cachedUser!.currentRoleId ==
                                              1
                                          ? 2
                                          : 1);
                                } else {
                                  await AuthService().addRole(
                                      roleId: userManager
                                                  .cachedUser!.currentRoleId ==
                                              1
                                          ? 2
                                          : 1);
                                }
                              }
                            },
                          )),
            ),
          ],
        ),
      );
    });
  }
}
