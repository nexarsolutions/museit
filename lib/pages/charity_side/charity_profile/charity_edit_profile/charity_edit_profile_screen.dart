import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musit/constants/text_styles.dart';

import '../../../../utils/global_functions.dart';
import '../../../../utils/image_picker_bottom_sheet.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_button.dart' show CustomButton;
import '../../../../widgets/custom_text_field.dart';
import 'controller/charity_edit_profile_controller.dart';

class CharityEditProfileScreen extends StatelessWidget {
  CharityEditProfileScreen({super.key});
  final controller = Get.put(CharityEditProfileController());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(text: 'Edit profile', isBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 145,
                            height: 145,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              // Use ClipOval to make the image circular
                              child: Obx(
                                    () => controller.imagePath.isNotEmpty
                                    ? Image.file(
                                  File(controller.imagePath.value),
                                  fit: BoxFit.cover,
                                )
                                    : Image.asset(
                                  'assets/images/dummy_profile.png',
                                  // Scale the dummy image down
                                  scale: 4.0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: -3,
                            bottom: -3,
                            child: GestureDetector(
                              onTap: () async {
                                pickImageBottomSheetFromCameraGallery(
                                      () async {
                                    String? pickedImagePath = await pickImage(
                                      ImageSource.camera,
                                    );
                                    if (pickedImagePath != null) {
                                      controller.imagePath.value =
                                          pickedImagePath;
                                      Get.back();
                                    }
                                  },
                                      () async {
                                    String? pickedImagePath = await pickImage(
                                      ImageSource.gallery,
                                    );
                                    if (pickedImagePath != null) {
                                      controller.imagePath.value =
                                          pickedImagePath;
                                      Get.back();
                                    }
                                  },
                                );
                              },
                              child: Image.asset(
                                'assets/images/camera_icon.png',
                                scale: 4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Username',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.userNameController,
                      hintText: 'Add text',
                      validator: validateName,
                      isPrefixIcon: true,
                      prefixIcon: Image.asset('assets/images/person_icon.png',scale: 3.5,),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Email',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.emailController,
                      hintText: 'xyz@gmail.com',
                      validator: validateEmail,
                      isPrefixIcon: true,
                      prefixIcon: Image.asset('assets/images/email.png',scale: 3.5,),

                    ),
                    SizedBox(height: 10),
                    Text(
                      'Phone Number',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.phoneNumberController,
                      hintText: '+125345245544',
                      validator: validatePhoneNumber,
                      isPrefixIcon: true,
                      prefixIcon: Image.asset('assets/images/mobile.png',scale: 3.5,),

                    ),
                    SizedBox(height: Get.height * 0.25),
                    Center(
                      child: CustomButton(
                        text: 'Save',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Get.back();
                          }
                        },
                      ),
                    ),
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
