import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musit/utils/extensions.dart';

import '../constants/text_styles.dart';
import '../utils/global_functions.dart';
import '../utils/image_picker_bottom_sheet.dart'; // where pickImage() and bottom sheet live

class CustomImagePicker extends StatelessWidget {
  final RxString pickedImagePath;
  final double height;
  final double borderRadius;
  final Color dottedColor;

  const CustomImagePicker({
    super.key,
    required this.pickedImagePath,
    this.height = 130,
    this.borderRadius = 15,
    this.dottedColor = Colors.blue,
  });

  Future<void> _handleUploadTap() async {
    pickImageBottomSheetFromCameraGallery(
      () async {
        final path = await pickImage(ImageSource.camera);
        if (path != null) pickedImagePath.value = path;
        Get.back();
      },
      () async {
        final path = await pickImage(ImageSource.gallery);
        if (path != null) pickedImagePath.value = path;
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8C7FAC).withValues(alpha: 0.15),
            const Color(0xFF7695CA).withValues(alpha: 0.15),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(4),
        decoration: DottedDecoration(
          color: dottedColor,
          strokeWidth: 1.2,
          shape: Shape.box,
          dash: const [3, 5],
          borderRadius: BorderRadius.circular(borderRadius - 5),
        ),
        child: Obx(
          () => pickedImagePath.value.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _handleUploadTap,
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
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              : pickedImagePath.value.contains('http')
                  ? Center(
                      child: Image.network(
                        pickedImagePath.value.showImage,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topRight,
                        children: [
                          Image.file(
                            File(pickedImagePath.value),
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: -5,
                            right: -5,
                            child: GestureDetector(
                              onTap: () => pickedImagePath.value = '',
                              child: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
