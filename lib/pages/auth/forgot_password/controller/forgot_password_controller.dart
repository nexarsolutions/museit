import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';

import '../../../../constants/text_styles.dart';
import '../../../../widgets/custom_bottom_sheet.dart';
import '../../../../widgets/custom_button.dart';
import '../widget/change_forgot_password.dart';
import '../widget/forgot_otp_screen.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();

  RxInt userId = 0.obs;

  final otpController = TextEditingController();

  RxBool isCooldown = false.obs;
  RxInt cooldownSeconds = 0.obs;
  Timer? timer;

  Future<void> sendForgotPassword() async {
    final email = emailController.text.trim();

    await ApiService().handleResponse(
      loadingMsg: "Sending Mail",
      apiMethod: () async =>
          await ApiService().get("forgotPassword?email=$email"),
      onSuccess: (response) {
        userId.value = response['response']['id'];

        Get.to(() => ForgotOtpScreen(userId: userId.value));

        customBottomSheet(
          padding: EdgeInsets.only(
            top: 42,
            left: 33,
            right: 33,
            bottom: 24,
          ),
          child: Column(
            children: [
              Text(
                'An OTP has been sent to your email',
                style: manRopeSemiBold.copyWith(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              CustomButton(
                  onPressed: () {
                    Get.back();
                  },
                  text: 'Okay'),
            ],
          ),
        );
        startCooldown(120);
      },
    );
  }

  void startCooldown(int sec) {
    isCooldown.value = true;
    cooldownSeconds.value = sec;

    timer = Timer.periodic(Duration(seconds: 1), (t) {
      cooldownSeconds.value--;
      if (cooldownSeconds.value <= 0) {
        isCooldown.value = false;
        t.cancel();
      }
    });
  }

  Future<void> resendOtp() async {
    await ApiService().handleResponse(
      loadingMsg: 'Resending Otp',
      apiMethod: () async => await ApiService().post("resendOtp", {
        "userId": userId.value,
        "atLogin": false,
      }),
      onSuccess: (response) {
        customErrorSnackBar(content: response['message']);
        startCooldown(120);
      },
    );
  }

  Future<void> validateOtp() async {
    await ApiService().handleResponse(
      loadingMsg: "Validating",
      apiMethod: () async => await ApiService().post("validateOtp", {
        "userId": userId.value,
        "atLogin": false,
        "OTP": int.parse(otpController.text),
      }),
      onSuccess: (response) {
        Get.to(() => ChangeForgotPassword(
              userId: userId.value,
              otp: otpController.text,
            ));
      },
    );
  }
}
