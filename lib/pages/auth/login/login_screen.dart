import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/auth/login/controller/login_controller.dart';
import 'package:musit/pages/auth/signup/signup_screen.dart';
import 'package:musit/pages/auth/widget/auth_header.dart';
import 'package:musit/pages/recipient_side/home/recipient_home/recipient_home_screen.dart';
import 'package:musit/pages/sender_side/sender_home/sender_home/sender_home_screen.dart';
import 'package:musit/widgets/custom_button.dart';
import 'package:musit/widgets/custom_text_field.dart';

import '../../../utils/validators.dart';
import '../forgot_password/forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required this.isSender});
  final controller = Get.put(LoginController());
  final formKey = GlobalKey<FormState>();
  final bool isSender;
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
                            color: blackColor.withOpacity(0.5),
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
                          Get.to(
                            () => ForgotPasswordScreen(isSender: isSender),
                          );
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
                            isSender == true
                                ? Get.offAll(() => SenderHomeScreen())
                                : Get.offAll(() => RecipientHomeScreen());
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
                            Get.to(() => SignupScreen(isSender: isSender));
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
