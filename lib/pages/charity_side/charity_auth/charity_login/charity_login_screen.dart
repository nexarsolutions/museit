import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/auth/login/controller/login_controller.dart';
import 'package:musit/pages/auth/signup/signup_screen.dart';
import 'package:musit/pages/auth/widget/auth_header.dart';
import 'package:musit/pages/charity_side/charity_home/charity_home/charity_home_screen.dart';
import 'package:musit/widgets/custom_button.dart';
import 'package:musit/widgets/custom_text_field.dart';

import '../../../../utils/validators.dart';
import '../charity_forgot_password/charity_forgot_password_screen.dart';
import '../charity_sign_up/charity_signup_screen.dart';
import 'controller/charity_login_controller.dart';


class CharityLoginScreen extends StatelessWidget {
  CharityLoginScreen({super.key});
  final controller = Get.put(CharityLoginController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          AuthHeader(title: 'Log In'),
          SizedBox(height: 18),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 18),

                    Text(
                      'Email',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.emailController,
                      hintText: 'Add text',
                      isPrefixIcon: true,
                      prefixIcon: Image.asset(
                        'assets/images/email.png',
                        scale: 3.5,
                      ),
                      validator: validateEmail,
                    ),
                    SizedBox(height: 10),

                    Text(
                      'Password',
                      style: manRopeSemiBold.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 8),
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

                            color: blackColor,
                          ),
                        ),
                        validator: (value) {
                          return isPasswordValid(value);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => CharityForgotPasswordScreen());
                        },
                        child: Text(
                          'Forget Password?',
                          style: manRopeSemiBold.copyWith(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.22),
                    Center(
                      child: CustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Get.offAll(()=>CharityHomeScreen());
                          }
                        },
                        text: 'Log In',
                      ),
                    ),
                    SizedBox(height: 17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don’t have an account? ',
                          style: manRopeSemiBold.copyWith(fontSize: 12),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(()=>CharitySignupScreen());
                          },
                          child: Text(
                            'Sign Up',
                            style: manRopeSemiBold.copyWith(
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                              decorationColor: blackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
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
