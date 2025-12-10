import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/common_widgets/recipients_card.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/services/auth_service.dart';
import 'package:musit/services/upload_file_service.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/utils/image_picker_bottom_sheet.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_button.dart';
import 'package:musit/widgets/custom_tab_button.dart';

import '../../../../widgets/custom_text_field.dart';
import 'controller/all_recipients_controller.dart';

class AllRecipients extends StatelessWidget {
  AllRecipients({
    super.key,
    required this.onPressedSave,
  });

  final controller = Get.put(AllRecipientsController());
  final Function() onPressedSave;
  final RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            text: 'Recipients',
            isBack: true,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Column(
                children: [
                  Obx(
                    () => CustomTabButton(
                      tabNames: ['Recipients', 'Contact'],
                      selectedIndex: selectedIndex.value,
                      onTabSelected: (index) => selectedIndex.value = index,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Obx(
                        () => selectedIndex.value == 1
                            ? Column(children: [
                                /// IMPORT BUTTON
                                // Align(
                                //   alignment: Alignment.topRight,
                                //   child: IconButton(
                                //     onPressed: controller.importContact,
                                //     icon: Icon(Icons.import_contacts),
                                //     style: ButtonStyle(
                                //         backgroundColor:
                                //             WidgetStatePropertyAll(blackColor),
                                //         foregroundColor:
                                //             WidgetStatePropertyAll(whiteColor)),
                                //   ),
                                // ),

                                const SizedBox(height: 24),

                                /// NAME FIELD
                                CustomTextField(
                                  controller: controller.nameController,
                                  hintText: 'Full Name',
                                ),

                                const SizedBox(height: 16),

                                /// EMAIL FIELD
                                CustomTextField(
                                  controller: controller.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  hintText: 'Email',
                                ),

                                const SizedBox(height: 16),

                                /// PHONE FIELD
                                CustomTextField(
                                  controller: controller.phoneController,
                                  keyboardType: TextInputType.phone,
                                  hintText: 'Phone Number',
                                ),

                                const SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () {
                                    pickImageBottomSheet(
                                      (camera) {
                                        controller.selectedImage.value = camera;
                                      },
                                      (gallery) {
                                        controller.selectedImage.value =
                                            gallery;
                                      },
                                    );
                                  },
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Obx(
                                        () => CircleAvatar(
                                          radius: 45,
                                          backgroundColor: Color(0xFF8C7FAC)
                                              .withValues(alpha: 0.5),
                                          backgroundImage: controller
                                                      .selectedImage.value !=
                                                  null
                                              ? FileImage(File(controller
                                                  .selectedImage.value!))
                                              : controller.selectedLogo.value !=
                                                      null
                                                  ? AssetImage(controller
                                                      .selectedLogo
                                                      .value!) as ImageProvider
                                                  : null /*AssetImage(
                                                      controller.logoList[0])*/
                                          ,
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 14,
                                        backgroundColor: Colors.black,
                                        child: Icon(Icons.camera_alt,
                                            size: 16, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 16),
                                SizedBox(
                                  height: 90,
                                  child: SingleChildScrollView(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      spacing: 10,
                                      children: List.generate(
                                        controller.logoList.length,
                                        (index) => GestureDetector(
                                          onTap: () => {
                                            controller.selectedLogo.value =
                                                controller.logoList[index],
                                            controller.selectedImage.value =
                                                null
                                          },
                                          child: CircleAvatar(
                                            radius: 45,
                                            backgroundImage: AssetImage(
                                                controller.logoList[index]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ])
                            : FutureBuilder(
                                // key: ValueKey(controller.searchQuery.value),
                                future:
                                    AuthService().getAllFilteredRecipients(),
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
                                          child: Text("Empty",
                                              style: manRopeSemiBold)),
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
                                          bool? isSelected = controller
                                              .selectedUsersId.value
                                              .any(
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
                                                if (userList[index].id !=
                                                    null) {
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
                ],
              ),
            ),
          ),
          CustomButton(
              onPressed: () async {
                if (selectedIndex.value == 1 &&
                    controller.nameController.text.trim().isEmpty) {
                  customErrorSnackBar(content: "Please fill the name field");
                  return;
                }
                if (selectedIndex.value == 1 &&
                    controller.emailController.text.trim().isEmpty &&
                    controller.phoneController.text.trim().isEmpty) {
                  customErrorSnackBar(content: "Please fill the email/phone");
                  return;
                }

                String? netImage;

                if (controller.selectedImage.value != null &&
                    selectedIndex.value == 1 &&
                    controller.selectedImage.value != '') {
                  netImage = await UploadFileService().fileUploadResult(
                      uploadData: controller.selectedImage.value!);
                }

                await ApiService().handleResponse(
                  apiMethod: () async => await ApiService().post(
                      "recipients/default/add",
                      selectedIndex.value == 0
                          ? {
                              "recipientIds": controller.selectedUsersId.value
                                  .map((e) => e)
                                  .toList(),
                            }
                          : {
                              if (controller.nameController.text
                                  .trim()
                                  .isNotEmpty)
                                "name": controller.nameController.text.trim(),
                              if (controller.emailController.text
                                  .trim()
                                  .isNotEmpty)
                                "email": controller.emailController.text.trim(),
                              if (controller.phoneController.text
                                  .trim()
                                  .isNotEmpty)
                                "phone": controller.phoneController.text.trim(),
                              "picture": netImage ??
                                  "https://museit-s3bucket.s3.amazonaws"
                                      ".com/1764239445835-app_icon.jpg"
                            }),
                  onSuccess: (response) {
                    onPressedSave();

                    customErrorSnackBar(content: response['message']);
                  },
                );
              },
              text: "Save"),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
