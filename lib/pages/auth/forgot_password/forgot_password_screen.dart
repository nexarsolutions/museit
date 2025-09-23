import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/auth/widget/auth_header.dart';
import 'package:musit/utils/validators.dart';
import 'package:musit/widgets/custom_bottom_sheet.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import 'controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key, required this.isSender});

  final controller = Get.put(ForgotPasswordController());
  final formKey = GlobalKey<FormState>();
final bool isSender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          AuthHeader(title: 'Forgot Password', isBack: true),
          SizedBox(height: 18),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Not to worry, it happens to the best of us. Please enter your email address below.',
                        style: manRopeSemiBold.copyWith(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email',
                        style: manRopeSemiBold.copyWith(fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      controller: controller.emailController,
                      hintText: 'Example@example.com',
                      keyboardType: TextInputType.emailAddress,
                      isPrefixIcon: true,
                      validator: validateEmail,
                      prefixIcon: Image.asset(
                        'assets/images/email.png',
                        height: 24,
                        width: 24,
                        scale: 4,
                      ),
                    ),
                    const SizedBox(height: 42),
                    Center(
                      child: CustomButton(
                        text: 'Submit',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
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
                                    'A reset link has been emailed to you. Please also check your spam.',
                                    style: manRopeSemiBold.copyWith(
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 50),
                                  CustomButton(onPressed: () {
                                    Get.back();
                                  }, text: 'Okay'),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 25),
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
