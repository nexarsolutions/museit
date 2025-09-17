import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/auth/widget/auth_header.dart';
import 'package:pinput/pinput.dart';

import '../../../widgets/custom_button.dart';
import '../../subscriptions/subscriptions/subscription_screen.dart';
import 'controller/verify_controller.dart';

class VerifyScreen extends StatelessWidget {
  VerifyScreen({super.key});

  final controller = Get.put(VerifyController());

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
              child: Column(
                children: [
                  SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Enter the 6 digit code we have sent to xyzabc@gmail.com',
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
                  ),
                  const SizedBox(height: 6),
                  Obx(
                    () =>
                        controller.onClick.value == true &&
                            controller.pinController.text.isEmpty
                        ? Text(
                            "Enter the code.",
                            style: manRope.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : controller.onClick.value == true &&
                              controller.pinController.text.length != 6
                        ? Text(
                            "The code must be of 6 digits.",
                            style: manRope.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : controller.onClick.value == true &&
                              !controller.isNumeric(
                                controller.pinController.text,
                              )
                        ? Text(
                            "Please enter a valid code.",
                            style: manRope.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 42),
                  CustomButton(
                    text: 'Verify',
                    onPressed: () {
                      controller.onClick.value = !controller.onClick.value;
                      String pin = controller.pinController.text.trim();
                      if (pin.isEmpty ||
                          pin.length != 6 ||
                          !controller.isNumeric(pin)) {
                        controller.onClick.value = true;
                      } else if (controller.pinController.length == 6 ||
                          controller.isNumeric(pin)) {
                        Get.offAll(() => SubscriptionScreen());
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
                            builder:
                                (
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
                      controller.resend();
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
        ],
      ),
    );
  }
}
