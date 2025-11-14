import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/pages/auth/login/login_screen.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/utils/validators.dart';
import 'package:musit/widgets/custom_button.dart';
import 'package:musit/widgets/custom_text_field.dart';

import '../../../../constants/colors.dart';
import '../../widget/auth_header.dart';

class ChangeForgotPassword extends StatelessWidget {
  final int userId;
  final String otp;

  ChangeForgotPassword({super.key, required this.userId, required this.otp});

  final controller = TextEditingController();
  final _fromkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          AuthHeader(title: 'Reset Password', isBack: true),
          SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _fromkey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: controller,
                      hintText: "New Password",
                      obscureText: true,
                      validator: isPasswordValid,
                    ),
                    const SizedBox(height: 48),
                    CustomButton(
                      text: 'Update Password',
                      onPressed: () {
                        if (_fromkey.currentState!.validate()) {
                          changePassword();
                        }
                      },
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

  Future<void> changePassword() async {
    print('''${{
      "userId": userId,
      "password": controller.text,
      "OTP": int.parse(otp),
    }}''');
    await ApiService().handleResponse(
      loadingMsg: 'Changing password',
      apiMethod: () async => await ApiService().put("changePassword", {
        "userId": userId,
        "password": controller.text,
        "OTP": int.parse(otp),
      }),
      onSuccess: (response) {
        Get.offAll(() => LoginScreen());
        customErrorSnackBar(content: response['message']);
      },
    );
  }
}
