import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_styles.dart';
import '../../../../utils/dialog_utilities.dart';
import '../../../../widgets/custom_button.dart';
import '../../widget/auth_header.dart';
import '../controller/forgot_password_controller.dart';

class ForgotOtpScreen extends StatelessWidget {
  final int userId;

  ForgotOtpScreen({super.key, required this.userId});

  final controller = Get.put(ForgotPasswordController());
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    controller.userId.value = userId;

    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          AuthHeader(title: 'Verify Otp', isBack: true),
          SizedBox(height: 18),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _fromKey,
                child: Column(
                  children: [
                    SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Enter OTP sent to your email ${controller.emailController.text.trim()}',
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
                      controller: controller.otpController,
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
                        if (_fromKey.currentState!.validate()) {
                          controller.validateOtp();
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
                      () => !controller.isCooldown.value
                          ? const SizedBox()
                          : TweenAnimationBuilder<Duration>(
                              duration: const Duration(seconds: 90),
                              tween: Tween(
                                begin: const Duration(seconds: 90),
                                end: Duration.zero,
                              ),
                              onEnd: () {
                                controller.isCooldown.value = false;
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
                        if (!controller.isCooldown.value) {
                          controller.resendOtp();
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
