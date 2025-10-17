import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';

void customBottomSheet({
  required Widget child,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  Color? backgroundColor,
  double? maxHeight,
}) {
   Get.bottomSheet(
    isDismissible: true,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    SafeArea(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Container(
          margin: margin??const EdgeInsets.only(left: 8,right: 8,top: 24),
          constraints: BoxConstraints(maxHeight: maxHeight??Get.height * 0.7),
          width: Get.width,
          decoration: BoxDecoration(
            color: backgroundColor??whiteColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: padding ?? const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
              child: child,
            ),
          ),
        ),
      ),
    ),
  );
}
