import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/common_widgets/recipients_card.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/sender_side/sender_home/playlist_sent_bottom_sheet/playlist_sent_bottom_sheet.dart';
import 'package:musit/pages/sender_side/sender_home/sender_view_recipient/controller/sender_view_recipient_controller.dart';
import 'package:musit/services/auth_service.dart';
import 'package:musit/utils/dialog_utilities.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_button.dart';

import '../../../../widgets/custom_text_field.dart';

class SenderViewRecipientScreen extends StatelessWidget {
  SenderViewRecipientScreen({super.key, required this.onPressedSave});

  final controller = Get.put(SenderViewRecipientController());
  final RxBool isSelected = true.obs;
  final RxnString phoneString = RxnString();
  final Function(List<int> selectedUsersId, String? phone) onPressedSave;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            text: 'Recipients',
            isBack: true,
            showLastIcon: true,
            lastWidget: Image.asset(
              'assets/images/upload_icon_rounded.png',
              scale: 3.5,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Column(
                children: [
                  CustomTextField(
                    borderRadius: 50,
                    controller: controller.searchController,
                    hintText: 'Search',
                    isSuffixIcon: true,
                    suffixIcon: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: blackColor,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/search_icon.png',
                        scale: 3,
                      ),
                    ),
                    onChanged: (value) {
                      if (value.trim().isEmpty) {
                        controller.searchQuery.value = '';
                      } else {
                        controller.searchQuery.value = value.trim();
                      }
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Obx(
                        () => FutureBuilder(
                            key: ValueKey(controller.searchQuery.value),
                            future: AuthService().getAllUsers(
                                search: controller.searchQuery.value,
                                roleId: 2),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SizedBox(
                                  height: Get.height / 3,
                                  child: Center(
                                      child: CircularProgressIndicator()),
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
                                    child: TextButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  blackColor),
                                          foregroundColor:
                                              WidgetStatePropertyAll(
                                                  whiteColor),
                                        ),
                                        child: Text(
                                          "Send via Phone Number",
                                          // style: manRopeSemiBold,
                                        )),
                                  ),
                                  // child: Center(
                                  //     child: Text("No User Found",
                                  //         style: manRopeSemiBold)),
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
                                  return Obx(
                                    () {
                                      bool? isSelected =
                                          controller.selectedUsersId.value.any(
                                        (element) =>
                                            element == userList[index].id,
                                      );

                                      return RecipientsCard(
                                        user: userList[index],
                                        isSelected: isSelected,
                                        onTap: () {
                                          if (isSelected) {
                                            controller.selectedUsersId
                                                .removeWhere((element) =>
                                                    element ==
                                                    userList[index].id);
                                          } else {
                                            if (userList[index].id != null) {
                                              controller.selectedUsersId
                                                  .add(userList[index].id!);
                                            }
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            }),
                      ),
                    ),
                  ),
                  SizedBox(height: 42),
                  CustomButton(
                      onPressed: () {
                        // if (controller.selectedUsersId.value.isEmpty) {
                        //   errorDialog(
                        //       content: "Select User/Receipt to continue.");
                        //   return;
                        // }
                        onPressedSave(
                            controller.selectedUsersId, phoneString.value);
                      },
                      text: 'Send'),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        return isSelected.value
                            ? GestureDetector(
                                onTap: () {
                                  isSelected.value = false;
                                },
                                child: Image.asset(
                                  'assets/images/tick_purple.png',
                                  width: 22,
                                  height: 22,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  isSelected.value = true;
                                },
                                child: Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(
                                          0xFF8C7FAC,
                                        ).withValues(alpha: 0.15),
                                        Color(
                                          0xFF7695CA,
                                        ).withValues(alpha: 0.15),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                ),
                              );
                      }),
                      SizedBox(width: 12),
                      Text(
                        'Allow to share in community',
                        style: manRope.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          decoration: TextDecoration.underline,
                          decorationColor: blackColor,
                        ),
                      ),
                    ],
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
