import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/utils/extensions.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/global_functions.dart';
import '../../../../utils/image_picker_bottom_sheet.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_button.dart' show CustomButton;
import '../../../../widgets/custom_text_field.dart';
import 'controller/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final controller = Get.put(EditProfileController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(text: 'Edit profile', isBack: true),
          Expanded(
            child: FutureBuilder(
                future: controller.getUserInfoById(),
                // Use API instead of stream
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error occurred".tr,
                        style: manRope,
                      ),
                    );
                  } else if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final user = snapshot.data!;

                  return SingleChildScrollView(
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
                                Obx(() {
                                  final image = user.profile.value;
                                  final name = user.username.text;

                                  return Container(
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
                                      child: image != ''
                                          ? (image.startsWith('/') ||
                                                  image.startsWith('file'))
                                              ? Image.file(
                                                  File(image),
                                                  fit: BoxFit.cover,
                                                )
                                              : Image(
                                                  image:
                                                      CachedNetworkImageProvider(
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
                                                  style:
                                                      manRopeSemiBold.copyWith(
                                                    color: whiteColor,
                                                    fontSize:
                                                        50, // proportional to 145px size
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  );
                                }),
                                Positioned(
                                  right: -3,
                                  bottom: -3,
                                  child: GestureDetector(
                                    onTap: () async {
                                      pickImageBottomSheetFromCameraGallery(
                                        () async {
                                          String? pickedImagePath =
                                              await pickImage(
                                            ImageSource.camera,
                                          );
                                          if (pickedImagePath != null) {
                                            user.profile.value =
                                                pickedImagePath;
                                            Get.back();
                                          }
                                        },
                                        () async {
                                          String? pickedImagePath =
                                              await pickImage(
                                            ImageSource.gallery,
                                          );
                                          if (pickedImagePath != null) {
                                            user.profile.value =
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
                            controller: user.username,
                            hintText: 'Add text',
                            validator: validateName,
                            isPrefixIcon: true,
                            prefixIcon: Image.asset(
                              'assets/images/person_icon.png',
                              scale: 3.5,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Email',
                            style: manRopeSemiBold.copyWith(fontSize: 12),
                          ),
                          SizedBox(height: 8),
                          CustomTextField(
                            controller: user.email,
                            hintText: 'xyz@gmail.com',
                            validator: validateEmail,
                            isPrefixIcon: true,
                            readOnly: true,
                            prefixIcon: Image.asset(
                              'assets/images/email.png',
                              scale: 3.5,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Phone Number',
                            style: manRopeSemiBold.copyWith(fontSize: 12),
                          ),
                          SizedBox(height: 8),
                          CustomTextField(
                            controller: user.phone,
                            hintText: '+125345245544',
                            validator: validatePhoneNumber,
                            isPrefixIcon: true,
                            prefixIcon: Image.asset(
                              'assets/images/mobile.png',
                              scale: 3.5,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.25),
                          Center(
                            child: CustomButton(
                              text: 'Save',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  controller.updateProfile(user: user);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
