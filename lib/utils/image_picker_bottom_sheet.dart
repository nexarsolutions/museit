import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';

import '../widgets/custom_button.dart';

void pickImageBottomSheetFromCameraGallery(
  void Function() onCameraPressed,
  void Function() onGalleryPressed,
) {
  Get.bottomSheet(
    BottomSheet(
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
          children: [
            const SizedBox(height: 42),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: CustomButton(
                text: 'Camera',
                 onPressed: onCameraPressed,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: CustomButton(
                text: 'Gallery',
                onPressed: onGalleryPressed,
              ),
            ),
          ],
        );
      },
    ),
  );
}
