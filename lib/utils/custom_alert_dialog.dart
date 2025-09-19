import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';

import '../widgets/custom_button.dart';

void customAlertDialog(String title, String content, [Widget? buttonWidget]) {
  showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: AlertDialog(
          surfaceTintColor: blackColor,
          backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actionsAlignment: MainAxisAlignment.center,
          title: Container(
            padding: const EdgeInsets.all(15),
            decoration:  BoxDecoration(
              color: blackColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: manRopeSemiBold.copyWith(color: whiteColor),

            ),
          ),
          titlePadding: EdgeInsets.zero,
          content: Text(
            textAlign: TextAlign.center,
            content,
            style: manRopeSemiBold.copyWith(fontSize: 12),
          ),
          actions: [
            Center(
              child: CustomButton(
                onPressed: () {
                  Get.back();
                },
                height: 36,
                text: 'Okay',
                width: 150,
                verticalPadding: 0,
                borderRadius: 12,
              ),
            ),
            Center(child: buttonWidget ?? const SizedBox.shrink())
          ],
        ),
      );
    },
  );
}
