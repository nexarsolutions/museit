import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyController extends GetxController {
  final pinController = TextEditingController();

  var onClick = false.obs;
  RxString errorMessage = "".obs;
  RxBool isHide = false.obs;

  bool isNumeric(String str) {
    if (str == '') {
      return false;
    }
    return double.tryParse(str) != null;
  }

  resend() async {
    isHide.value = true;
    await Future.delayed(
      const Duration(milliseconds: 5),
      () => isHide.value = false,
    );
  }
}
