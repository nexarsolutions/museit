import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/auth/widget/auth_header.dart';

import '../../../constants/text_styles.dart';
import '../../../utils/validators.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../verify/verify_screen.dart';
import 'controller/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key,});

  final controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          AuthHeader(title: 'Sign Up'),
          SizedBox(height: 18),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 18),
                    Text('Username', style: manRopeSemiBold.copyWith(fontSize: 12)),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.nameController,
                      hintText: 'Add text',
                      isPrefixIcon: true,
                      prefixIcon: Image.asset(
                        'assets/images/person_icon.png',
                        scale: 3,
                      ),
                      validator: validateName,
                    ),
                    const SizedBox(height: 10),
                    Text('Email', style: manRopeSemiBold.copyWith(fontSize: 12)),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.emailController,
                      hintText: 'Example@example.com',
                      keyboardType: TextInputType.emailAddress,
                      isPrefixIcon: true,
                      prefixIcon: Image.asset(
                        'assets/images/email.png',
                        height: 24,
                        width: 24,
                        scale: 4,
                      ),
                      validator: validateEmail,
                    ),
                    const SizedBox(height: 10),
                    Text('Phone Number', style: manRopeSemiBold.copyWith(fontSize: 12)),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.phoneNumberController,
                      hintText: '+92 123456789',
                      keyboardType: TextInputType.phone,
                      isPrefixIcon: true,
                      prefixIcon: Image.asset(
                        'assets/images/mobile.png',
                        height: 24,
                        width: 24,
                        scale: 4,
                      ),
                      validator: validatePhoneNumber,
                    ),
                    const SizedBox(height: 10),
                    Text('Password', style: manRopeSemiBold.copyWith(fontSize: 12)),
                    const SizedBox(height: 8),
                    Obx(
                      () => CustomTextField(
                        controller: controller.passwordController,
                        hintText: '************',
                        obscureText: controller.showPassword.value,
                        keyboardType: TextInputType.visiblePassword,
                        isPrefixIcon: true,
                        prefixIcon: Image.asset(
                          'assets/images/lock.png',
                          height: 24,
                          width: 24,
                          scale: 3.5,
                        ),
                        isSuffixIcon: true,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.showPassword.toggle();
                          },
                          child: Icon(
                            controller.showPassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 20,
                            color: blackColor.withOpacity(0.5),
                          ),
                        ),
                        validator: (value) {
                          return isPasswordValid(value);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('Confirm password', style: manRopeSemiBold.copyWith(fontSize: 12)),
                    const SizedBox(height: 8),
                    Obx(
                      () => CustomTextField(
                        controller: controller.confirmPasswordController,
                        hintText: '************',
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: controller.showConfirmPassword.value,
                        isPrefixIcon: true,
                        prefixIcon: Image.asset(
                          'assets/images/lock.png',
                          height: 24,
                          width: 24,
                          scale: 3.5,
                        ),
                        isSuffixIcon: true,
                        suffixIcon: GestureDetector(
                          child: Icon(
                            controller.showConfirmPassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 20,

                            color: blackColor.withOpacity(0.5),
                          ),
                          onTap: () {
                            controller.showConfirmPassword.toggle();
                          },
                        ),
                        validator: (value) {
                        return isConfirmPasswordValid(
                          value,
                          controller.passwordController.text,
                        );
                      },

                      ),
                    ),
                    const SizedBox(height: 42),
                    Center(
                      child: CustomButton(
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            Get.to(() => VerifyScreen());
                          }
                        },
                        text: 'Sign up',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: manRopeSemiBold.copyWith(fontSize: 12),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Text(
                            'Log in',
                            style: manRopeSemiBold.copyWith(
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                              decorationColor: blackColor,
                            ),
                          ),
                        ),
                      ],
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
