import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/auth/signup/controller/signup_controller.dart';
import 'package:musit/pages/auth/widget/auth_header.dart';
import 'package:musit/utils/dialog_utilities.dart';
import 'package:pinput/pinput.dart';

import '../../../widgets/custom_button.dart';

class VerifyScreen extends StatelessWidget {
  VerifyScreen({super.key});

  final controller = Get.put(SignupController());

  final _verifyFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          AuthHeader(title: 'Verify email', isBack: true),
          SizedBox(height: 18),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _verifyFormKey,
                child: Column(
                  children: [
                    SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Enter the 6 digit code we have sent to ${controller.userModel.email.text.trim()}',
                        style: manRopeSemiBold.copyWith(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Pinput(
                      defaultPinTheme: PinTheme(
                        textStyle: manRopeSemiBold.copyWith(fontSize: 24),
                        width: 48,
                        height: 52,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF8C7FAC).withValues(alpha: 0.15),
                              Color(0xFF7695CA).withValues(alpha: 0.15),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      length: 6,
                      controller: controller.pinController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Enter the code.";
                        } else if (value.length != 6) {
                          return "The code must be of 6 digits.";
                        } else if (!GetUtils.isNum(value)) {
                          return "Please enter a valid code.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 42),
                    CustomButton(
                      text: 'Verify',
                      onPressed: () {
                        if (_verifyFormKey.currentState!.validate()) {
                          int enteredOtp = int.tryParse(
                                  controller.pinController.text.trim()) ??
                              0;
                          if (enteredOtp != controller.verificationCode.value) {
                            errorDialog(content: "OTP is invalid or expired.");
                            return;
                          } else {
                            controller.addUser();
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 58),
                    Text(
                      "Haven't received the OTP code yet?",
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => controller.isHide.value
                          ? const SizedBox()
                          : TweenAnimationBuilder<Duration>(
                              duration: const Duration(seconds: 90),
                              tween: Tween(
                                begin: const Duration(seconds: 90),
                                end: Duration.zero,
                              ),
                              onEnd: () {
                                controller.isResendActive.value = true;
                              },
                              builder: (
                                BuildContext context,
                                Duration value,
                                Widget? child,
                              ) {
                                final minutes = value.inMinutes
                                    .remainder(60)
                                    .toString()
                                    .padLeft(2, '0');
                                final seconds = value.inSeconds
                                    .remainder(60)
                                    .toString()
                                    .padLeft(2, '0');
                                return Text(
                                  '$minutes:$seconds',
                                  style: manRopeSemiBold.copyWith(
                                    color: blackColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        if (controller.isResendActive.value) {
                          controller.sendEmail(isFromResendOtp: true);
                        } else {
                          errorDialog(content: "Wait for time to end");
                        }
                      },
                      child: Text(
                        'Resend!',
                        style: manRopeSemiBold.copyWith(
                          fontSize: 14,
                          color: blackColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
