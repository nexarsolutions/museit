// lib/modules/charity_profile_creation/charity_profile_creation_screen.dart
import 'dart:io';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/utils/extensions.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_button.dart';
import 'package:musit/widgets/custom_text_field.dart';
import '../../../utils/global_functions.dart';
import '../../../utils/image_picker_bottom_sheet.dart';
import 'controller/charity_profile_creation_controller.dart';

class CharityProfileCreationScreen extends StatelessWidget {
  CharityProfileCreationScreen({super.key});

  final controller = Get.put(CharityProfileCreationController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        top: false,
        child: Obx(() => Stack(
              children: [
                Column(
                  children: [
                    const CustomAppBar(text: 'Charity Profile Creation'),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              if (controller.isSelected.value == 0)
                                _buildStep1(context)
                              else if (controller.isSelected.value == 1)
                                _buildFrontId()
                              else if (controller.isSelected.value == 2)
                                _buildBackId()
                              else
                                _buildFace(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (controller.isLoading.value)
                  Container(
                    color: Colors.black.withOpacity(0.4),
                    child: const Center(
                        child: CircularProgressIndicator(color: whiteColor)),
                  ),
              ],
            )),
      ),
    );
  }

  Widget _buildStep1(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 22),
        _label('Organization Name'),
        CustomTextField(
          controller: controller.organizationNameController,
          hintText: 'Add text',
          validator: (v) => v!.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 10),
        _label('Address'),
        CustomTextField(
          controller: controller.addressController,
          hintText: 'Add text',
          validator: (v) => v!.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 10),
        _label('Registration Certificate'),
        const SizedBox(height: 8),
        _uploadBox(
          imagePath: controller.registrationCertPath,
          onTap: () async {
            pickImageBottomSheet(
                  (camera) => controller.registrationCertPath
                  .value=camera,
              // () async {
              //   String? pickedImagePath = await pickImage(
              //     ImageSource.camera,
              //   );
              //   if (pickedImagePath != null) {
              //     controller.registrationCertPath.value = pickedImagePath;
              //     Get.back();
              //   }
              // },
                  (gallery) => controller.registrationCertPath
                  .value=gallery,
              // () async {
              //   String? pickedImagePath = await pickImage(
              //     ImageSource.gallery,
              //   );
              //   if (pickedImagePath != null) {
              //     controller.registrationCertPath.value = pickedImagePath;
              //     Get.back();
              //   }
              // },
            );
          },
        ),
        const SizedBox(height: 10),
        _label('Bank Name'),
        CustomTextField(
          controller: controller.bankNameController,
          hintText: 'Add text',
          validator: (v) => v!.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 10),
        _label('Account Number'),
        CustomTextField(
          controller: controller.accountNumberController,
          hintText: 'Add text',
          validator: (v) => v!.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 10),
        _label('Account Title'),
        CustomTextField(
          controller: controller.accountTitleController,
          hintText: 'Add text',
          validator: (v) => v!.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 10),
        _label('Owner ID'),
        CustomTextField(
          controller: controller.ownerIdController,
          hintText: 'Add text',
          validator: (v) => v!.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 36),
        Center(
          child: CustomButton(
            text: 'Next',
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                await controller.submitStep1();
              }
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildFrontId() => _imageStep(
        title: 'Upload Front ID',
        imagePath: controller.frontIdPath,
        onTap: () async {
          String? pickedImagePath = await pickImage(
            ImageSource.camera,
          );
          if (pickedImagePath != null) {
            controller.frontIdPath.value = pickedImagePath;
          }
        },
        onNext: controller.submitFrontId,
      );

  Widget _buildBackId() => _imageStep(
        title: 'Upload Back ID',
        imagePath: controller.backIdPath,
        onTap: () async {
          String? pickedImagePath = await pickImage(
            ImageSource.camera,
          );
          if (pickedImagePath != null) {
            controller.backIdPath.value = pickedImagePath;
          }
        },
        onNext: controller.submitBackId,
      );

  Widget _buildFace() => _imageStep(
        title: 'Selfie Verification',
        imagePath: controller.facePath,
        onTap: () async {
          String? pickedImagePath = await pickImage(
            ImageSource.camera,
          );
          if (pickedImagePath != null) {
            controller.facePath.value = pickedImagePath;
          }
        },
        onNext: controller.submitFace,
      );

  Widget _imageStep({
    required String title,
    required RxString imagePath,
    required VoidCallback onTap,
    required Future<void> Function() onNext,
  }) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Text(title, style: manRopeSemiBold.copyWith(fontSize: 16)),
        const SizedBox(height: 20),
        _uploadBox(imagePath: imagePath, onTap: onTap),
        const SizedBox(height: 40),
        CustomButton(text: 'Next', onPressed: onNext),
      ],
    );
  }

  Widget _uploadBox({
    required RxString imagePath,
    required VoidCallback onTap,
  }) {
    return Obx(() => GestureDetector(
          onTap: onTap,
          child: Container(
            width: Get.width,
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF8C7FAC).withValues(alpha: 0.15),
                  const Color(0xFF7695CA).withValues(alpha: 0.15),
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
                  color: Colors.blue,
                  strokeWidth: 1.2,
                  shape: Shape.box,
                  dash: const [3, 5],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: imagePath.value.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/upload_icon.png',
                            height: 30,
                            width: 30,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(height: 13),
                          Text(
                            'Upload',
                            style: manRopeSemiBold.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    : imagePath.value.contains('http')
                        ? Center(
                            child: Image.network(
                              imagePath.value.showImage,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.topRight,
                              children: [
                                Image.file(
                                  File(imagePath.value),
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: -5,
                                  right: -5,
                                  child: GestureDetector(
                                    onTap: () => imagePath.value = '',
                                    child: const Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
          ),
        ));
  }

  Widget _label(String text) =>
      Text(text, style: manRopeSemiBold.copyWith(fontSize: 12));
}
