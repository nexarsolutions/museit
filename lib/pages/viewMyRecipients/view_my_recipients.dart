import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/common_widgets/recipients_card.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/globalModels/user_model.dart';
import 'package:musit/services/auth_service.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../main.dart';
import '../sendBottombar/controller/sender_bottom_bar_controller.dart';

class ViewMyRecipients extends StatelessWidget {
  ViewMyRecipients({
    super.key,
  });

  final RxBool switchValue = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            text: 'Recipients',
            isBack: true,
            onTap: () {
              Get.put(SenderBottomBarController()).selectedTab.value = 1;
            },
            lastWidget: Row(
              spacing: 4,
              children: [Text(
                userManager.cachedUser?.currentRoleId == 1
                    ? 'Receiver '
                    : 'Sender ',
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.bold, color: blackColor),
              ),
                SizedBox(
                  width: 40,
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
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Obx(
                () => FutureBuilder(
                    future: AuthService().getAllMyRecipients(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: Get.height / 3,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (snapshot.hasError) {
                        return SizedBox(
                          height: Get.height / 3,
                          child: Center(
                              child: Text(snapshot.error.toString(),
                                  style: manRopeSemiBold)),
                        );
                      }

                      if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return SizedBox(
                          height: Get.height / 3,
                          child: Center(
                              child: Text("Empty", style: manRopeSemiBold)),
                        );
                      }

                      final userList = snapshot.requireData;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        primary: false,
                        padding: EdgeInsets.only(bottom: 30),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 13.0,
                          mainAxisSpacing: 10.0,
                          mainAxisExtent: 150,
                        ),
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          final user = userList[index];
                          return RecipientsCard(
                            user: UserModel(
                                id: user.id,
                                username: TextEditingController(
                                    text: user.username ?? ''),
                                email: TextEditingController(
                                    text: user.email ?? ''),
                                profile: RxString(user.profile ?? '')),
                            isSelected: false,
                          );
                        },
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
