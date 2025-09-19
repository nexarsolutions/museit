import 'dart:io';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/utils/validators.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_button.dart';
import 'package:musit/widgets/custom_text_field.dart';

import '../../../../utils/custom_alert_dialog.dart';
import '../../../../utils/global_functions.dart';
import '../../../../utils/image_picker_bottom_sheet.dart';
import 'controller/edit_charity_profile_controller.dart';

class EditCharityProfileScreen extends StatelessWidget {
   EditCharityProfileScreen({super.key});
  final controller = Get.put(EditCharityProfileController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Edit Charity Profile',isBack: true,),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 22),
                    Text(
                      'Organization Name',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller:
                      controller.organizationNameController,
                      hintText: 'Add text',
                      isPrefixIcon: true,
                      prefixIcon: Image.asset(
                        'assets/images/organization_name_icon.png',
                        scale: 3.5,
                      ),
                      validator: validateIsEmpty,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Address',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.addressController,
                      hintText: 'Add text',
                      isPrefixIcon: true,
                      prefixIcon: Image.asset(
                        'assets/images/location_icon.png',
                        scale: 3.5,
                      ),
                      validator: validateIsEmpty,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Registration Certificate',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: Get.width,
                      height: 130,
                      decoration: BoxDecoration(
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

                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(4),
                        decoration: DottedDecoration(
                          color: purpleColor,
                          strokeWidth: 1.2,
                          shape: Shape.box,
                          dash: const [3, 5],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Obx(
                              () =>
                          controller
                              .pickedImagePath
                              .value
                              .isEmpty
                              ? Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  pickImageBottomSheetFromCameraGallery(
                                        () async {
                                      String?
                                      pickedImagePath =
                                      await pickImage(
                                        ImageSource
                                            .camera,
                                      );
                                      controller
                                          .pickedImagePath
                                          .value =
                                      pickedImagePath!;
                                      Get.back();
                                    },
                                        () async {
                                      String?
                                      pickedImagePath =
                                      await pickImage(
                                        ImageSource
                                            .gallery,
                                      );
                                      controller
                                          .pickedImagePath
                                          .value =
                                      pickedImagePath!;
                                      Get.back();
                                    },
                                  );
                                },
                                child: Image.asset(
                                  'assets/images/upload_icon.png',
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(height: 13),
                              Text(
                                'Upload',
                                style: manRopeSemiBold
                                    .copyWith(
                                  fontSize: 10,
                                  fontWeight:
                                  FontWeight.w900,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          )
                              : Center(
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.topRight,
                              children: [
                                Image.file(
                                  File(
                                    controller
                                        .pickedImagePath
                                        .value,
                                  ),
                                ),
                                Positioned(
                                  top: -5,
                                  right: -5,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller
                                          .pickedImagePath
                                          .value =
                                      '';
                                    },
                                    child: const Icon(
                                      size: 20,
                                      Icons.cancel,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Bank Name',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.bankNameController,
                      hintText: 'Add text',
                      validator: validateIsEmpty,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Account Number',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller:
                      controller.accountNumberController,
                      hintText: 'Add text',
                      validator: validateIsEmpty,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Account Title',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.accountTitleController,
                      hintText: 'Add text',
                      validator: validateIsEmpty,
                    ),

                    SizedBox(height: 10),
                    Text(
                      'ID of Owner',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.ifOfOwnerController,
                      hintText: 'Add text',
                      validator: validateIsEmpty,
                    ),
                    SizedBox(height: 36),
                    Center(
                      child: CustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (controller
                                .pickedImagePath
                                .value
                                .isEmpty) {
                              customAlertDialog(
                                'No image selected',
                                'Please upload a certificate image before proceeding, as it is required to continue with this action.',
                              );
                            } else {
                              Get.back();
                            }
                          }
                        },
                        text: 'Next',
                      ),
                    ),
                    SizedBox(height: 24,)
                  ],
                ),
              ),
            ),
          )        ],
      ),
    );
  }
}
