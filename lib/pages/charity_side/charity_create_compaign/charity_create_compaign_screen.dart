import 'dart:io';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/charity_side/charity_create_compaign/controller/charity_create_compaign_controller.dart';
import 'package:musit/utils/validators.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_text_field.dart';

import '../../../utils/custom_alert_dialog.dart';
import '../../../utils/global_functions.dart';
import '../../../utils/image_picker_bottom_sheet.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_drop_down.dart';

class CharityCreateCompaignScreen extends StatelessWidget {
  CharityCreateCompaignScreen({super.key});
  final controller = Get.put(CharityCreateCompaignController());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Create Compaign', isBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Campaign Title',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.compaignTitleController,
                      hintText: 'Add text',
                      validator: validateIsEmpty,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Monthly Aid Goal',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.monthlyAidGoalController,
                      hintText: 'Add text',
                      keyboardType: TextInputType.number,
                      validator: validateIsEmpty,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Monthly Aid Goal',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),

                    CustomDropDown(
                      dropdownItems: controller.playlistList,
                      hintText: controller.selectedPlaylist.value,
                      onChanged: (value) {
                        controller.selectedPlaylist.value = value!;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select Playlist';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Cause',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.causeController,
                      hintText: 'Add text',
                      maxLines: 6,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      validator: validateIsEmpty,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Upload Image',
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
                    SizedBox(height: 10),
                    Text(
                      'Goal Amount',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.goalAmountController,
                      hintText: 'Add text',
                      keyboardType: TextInputType.numberWithOptions(),
                      validator: validateIsEmpty,
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
                      controller: controller.accountNumberController,
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
                    SizedBox(height: 36),
                    Center(
                      child: CustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (controller.pickedImagePath.value.isEmpty) {
                              customAlertDialog(
                                'No image selected',
                                'Please upload a image before proceeding, as it is required to continue with this action.',
                              );
                            } else {
                              Get.back();
                            }
                          }
                        },
                        text: 'Publish',
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            if (controller.pickedImagePath.value.isEmpty) {
                              customAlertDialog(
                                'No image selected',
                                'Please upload a image before proceeding, as it is required to continue with this action.',
                              );
                            } else {
                              Get.back();
                            }
                          }
                        },
                        child: Container(
                          width: 220,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: blackColor, width: 1),
                          ),
                          child: Center(
                            child: Text(
                              'Save in Drafts',
                              style: manRopeSemiBold.copyWith(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 36),
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
