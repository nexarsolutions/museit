import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/utils/global_functions.dart';

import '../widgets/custom_button.dart';

void pickImageBottomSheet(
  Function(String camera) onCameraPressed,
  Function(String gallery) onGalleryPressed,
) {
  Get.bottomSheet(
    SafeArea(
      child: BottomSheet(
        backgroundColor: whiteColor,
        constraints: BoxConstraints(
          maxHeight: 200,
          minWidth: Get.width,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        onClosing: () {},
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: blackColor,
                ),
                title: Text("Take Photo"),
                titleTextStyle: manRopeSemiBold,
                onTap: () async {
                  Get.back();
                  String? selectedImage = await pickImage(ImageSource.camera);
                  if (selectedImage == null) {
                    customErrorSnackBar(content: "No Image taken");
                    return;
                  }
                  onCameraPressed(selectedImage);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.image,
                  color: blackColor,
                ),
                title: Text("Choose from Gallery"),
                titleTextStyle: manRopeSemiBold,
                onTap: () async {
                  Get.back();
                  String? selectedImage = await pickImage(ImageSource.gallery);
                  if (selectedImage == null) {
                    customErrorSnackBar(content: "No Image Selected");
                    return;
                  }
                  onGalleryPressed(selectedImage);
                },
              ),
            ],
          );
        },
      ),
    ),
  );
}
