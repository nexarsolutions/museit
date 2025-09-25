import 'dart:io';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/recipient_side/health_support/application/controller/application_controller.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_bottom_sheet.dart';
import 'package:musit/widgets/custom_button.dart';
import 'package:musit/widgets/custom_text_field.dart';

import '../../../../utils/global_functions.dart';
import '../../../../utils/image_picker_bottom_sheet.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../health_support_details/recipient_health_support_details_screen.dart';

class ApplicationScreen extends StatelessWidget {
  ApplicationScreen({super.key});

  final controller = Get.put(ApplicationController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Application', isBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Health Type',
                      style: manRopeSemiBold.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomDropDown(
                      dropdownItems: controller.healthTypeList,
                      hintText: controller.selectedHealthType.value,
                      onChanged: (value) {
                        controller.selectedHealthType.value = value!;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select health type';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Disease',
                      style: manRopeSemiBold.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.diseaseController,
                      hintText: 'Add Text',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter disease name';
                        }
                        if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                          return 'Disease name can only contain letters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Monthly Aid Goal',
                      style: manRopeSemiBold.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.monthlyAidGoalController,
                      hintText: 'Add Text',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter monthly aid goal';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Only numbers allowed';
                        }
                        if (int.tryParse(value)! <= 0) {
                          return 'Amount must be greater than zero';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Story',
                      style: manRopeSemiBold.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.storyController,
                      hintText: 'Add Text',
                      maxLines: 6,
                      contentPadding: EdgeInsets.all(12),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your story';
                        }
                        if (value.trim().length < 20) {
                          return 'Story must be at least 20 characters long';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Upload Proof',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: Get.width,
                      height: 130,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF8C7FAC).withValues(alpha: 0.15),
                            Color(0xFF7695CA).withValues(alpha: 0.15),
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
                          () => controller.pickedImagePath.value.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        pickImageBottomSheetFromCameraGallery(
                                          () async {
                                            String? pickedImagePath =
                                                await pickImage(
                                                  ImageSource.camera,
                                                );
                                            controller.pickedImagePath.value =
                                                pickedImagePath!;
                                            Get.back();
                                          },
                                          () async {
                                            String? pickedImagePath =
                                                await pickImage(
                                                  ImageSource.gallery,
                                                );
                                            controller.pickedImagePath.value =
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
                                      style: manRopeSemiBold.copyWith(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
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
                                        File(controller.pickedImagePath.value),
                                      ),
                                      Positioned(
                                        top: -5,
                                        right: -5,
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.pickedImagePath.value =
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
                    SizedBox(height: 16),
                    Text(
                      'Bank Name',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.bankNameController,
                      hintText: 'Add text',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter bank name';
                        }
                        if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                          return 'Bank name can only contain letters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Account Number',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.accountNumberController,
                      hintText: 'Add text',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter account number';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Account number can only contain digits';
                        }
                        if (value.length < 10 || value.length > 16) {
                          return 'Account number must be 10-16 digits';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Account Title',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.accountTitleController,
                      hintText: 'Add text',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter account title';
                        }
                        if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                          return 'Account title can only contain letters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: CustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (controller.pickedImagePath.value.isEmpty) {
                              Get.snackbar(
                                'Error',
                                'Please upload proof document/image',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.redAccent,
                                colorText: Colors.white,
                              );
                              return;
                            }

                            customBottomSheet(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                      vertical: 24,
                                    ),
                                    child: Text(
                                      'You will be notified once your application has been approved',
                                      style: manRopeSemiBold.copyWith(
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: 42),
                                  CustomButton(
                                    onPressed: () {
                                      Get.to(() => RecipientHealthSupportDetailsScreen());
                                    },
                                    text: 'Okay',
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        text: 'Submit',
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
