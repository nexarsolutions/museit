import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

void customErrorSnackBar({required String content}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      content: Text(content, style: manRope.copyWith(color: whiteColor)),
      backgroundColor: blackColor,
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,

    ),
  );
}
