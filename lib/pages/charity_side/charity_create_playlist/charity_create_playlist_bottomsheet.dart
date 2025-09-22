import 'dart:io';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/charity_side/charity_create_playlist/controller/charity_create_playlist_controller.dart';
import 'package:musit/pages/charity_side/charity_home/charity_add_songs/charity_add_songs_screen.dart';
import 'package:musit/utils/validators.dart';
import 'package:musit/widgets/custom_bottom_sheet.dart';
import 'package:musit/widgets/custom_text_field.dart';

import '../../../constants/colors.dart';
import '../../../utils/custom_alert_dialog.dart';
import '../../../utils/global_functions.dart';
import '../../../utils/image_picker_bottom_sheet.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_drop_down.dart';

charityCreatePlaylistBottomSheet() {
  final controller = Get.put(CharityCreatePlaylistController());
  final formKey = GlobalKey<FormState>();

  return customBottomSheet(
    child: Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Create Playlist',
              style: manRopeSemiBold.copyWith(fontSize: 14),
            ),
          ),
          const SizedBox(height: 24),
          Text('Playlist Title', style: manRopeSemiBold.copyWith(fontSize: 12)),
          SizedBox(height: 8),
          CustomTextField(
            controller: controller.playlistTitleController,
            hintText: 'Add Text',
            validator: validateIsEmpty,
          ),
          SizedBox(height: 16),
          Text('Select Purpose', style: manRopeSemiBold.copyWith(fontSize: 12)),
          SizedBox(height: 8),
          CustomDropDown(
            maxHeight: 200,
            dropdownItems: controller.purposeList,
            hintText: controller.selectedPurpose.value,
            onChanged: (value) {
              controller.selectedPurpose.value = value!;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Select purpose';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          Text('Upload Image', style: manRopeSemiBold.copyWith(fontSize: 12)),
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
                                  String? pickedImagePath = await pickImage(
                                    ImageSource.camera,
                                  );
                                  controller.pickedImagePath.value =
                                      pickedImagePath!;
                                  Get.back();
                                },
                                () async {
                                  String? pickedImagePath = await pickImage(
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
                            Image.file(File(controller.pickedImagePath.value)),
                            Positioned(
                              top: -5,
                              right: -5,
                              child: GestureDetector(
                                onTap: () {
                                  controller.pickedImagePath.value = '';
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
          SizedBox(height: 42),
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
                    Get.to(() => CharityAddSongsScreen());
                  }
                }
              },
              text: 'Add Songs',
            ),
          ),
        ],
      ),
    ),
  );
}
