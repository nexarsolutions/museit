import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:musit/globalModels/user_model.dart';
import 'package:musit/main.dart';
import 'package:musit/pages/auth/login/login_screen.dart';
import 'package:musit/pages/auth/verify/verify_screen.dart';
import 'package:musit/pages/charity_side/charity_profile_creation/charity_profile_creation_screen.dart';
import 'package:musit/pages/recipient_side/home/recipient_home/recipient_home_screen.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/services/auth_service.dart';
import 'package:musit/utils/dialog_utilities.dart';
import 'package:musit/utils/global_functions.dart';

import '../../../sendBottombar/sender_bottom_bar.dart';

class SignupController extends GetxController {
  final userModel = UserModel();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final pinController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  RxBool showPassword = true.obs;
  RxBool showConfirmPassword = true.obs;
  RxnInt roleId = RxnInt();

  RxBool isHide = false.obs;

  ///verification Code
  RxInt verificationCode = 000000.obs;
  RxBool isResendActive = false.obs;

  final _apiService = ApiService();
  final _authService = AuthService();

  RxBool switchValue = false.obs;


  //=================Check If Email Exists=========
  Future<void> checkEmailExists(int roleId) async {
    this.roleId.value = roleId;

    ///api doesn't exist yet
    await _apiService.handleResponse(
      loadingMsg: "Loading...",
      apiMethod: () => _authService.emailAlreadyExists(
          email: userModel.email.text.trim(), phone: userModel.phone.text),
      onSuccess: (response) async {
        // await Future.delayed(const Duration(milliseconds: 800));
        sendEmail();
      },
    );
  }

  //=================Send Mail=====================
  Future<void> sendEmail({bool isFromResendOtp = false}) async {
    try {
      loadingDialog(message: "Sending OTP");
      //email app credentials
      //todo: ask the client and change later
      String username = 'welcome@museit.life';
      String password = 'V;ib3.9hAEn.vO%N';
      //generating otp
      verificationCode.value = Random().nextInt(99999) + 100000;
      //assign smtp server and send message
      // final smtpServer = gmail(username, password);
      final smtpServer = SmtpServer(
        "rs6-lon.serverhostgroup.com",
        port: 465,
        ssl: true,
        username: username,
        password: password,
      );

      final message =
          _emailTemplate(username, verificationCode.value.toString());

      //sending mail
      await send(message, smtpServer);
      //close loading dialog
      Get.back();
      printInfo(info: verificationCode.value.toString());
      //navigate to verify email
      if (isFromResendOtp == false) {
        Get.to(() => VerifyScreen());
      } else {
        isHide.value = true;
        isResendActive.value = false;
        await Future.delayed(
          const Duration(milliseconds: 5),
          () => isHide.value = false,
        );
      }
    } on MailerException catch (e) {
      Get.back();
      errorDialog(title: "Failed", content: e.message);
    }
  }

  //=================Add Customer =================
  Future<void> addUser() async {
    try {
      loadingDialog(message: "Loading...");
      userModel.roleId = roleId.value ?? (-1);
      var data = userModel.toSignupViaEmailJson();
      data.addAll({"password": passwordController.text.trim()});

      Get.back();
      await _apiService.handleResponse(
        loadingMsg: "Signing Up...",
        apiMethod: () => _authService.signupViaEmail(data),
        onSuccess: (response) async {
          customPrint("Signup Response: $response");

          UserModel currentUser = UserModel.fromJson(response['response'])
            ..roleId = userModel.roleId;
          // await Future.delayed(const Duration(milliseconds: 2));
          //customErrorSnackBar(content: response['message']);
          currentUser.roleId == 1
              ? Get.offAll(() => SenderBottomBar())
              : currentUser.roleId == 2
                  ? Get.offAll(() => RecipientHomeScreen())
                  : currentUser.roleId == 3
                      ? Get.offAll(() => CharityProfileCreationScreen())
                      : Get.offAll(() => LoginScreen());

          successDialog(content: response['message']);
          await userManager.clearUser();
          userManager.cachedUser = currentUser;
        },
      );
    } catch (e) {
      Get.back();
      errorDialog(title: "Error", content: e.toString());
    }
  }

  Message _emailTemplate(String username, String verificationCode) {
    return Message()
      ..from = Address(username, "MUSEiT")
      ..recipients.add(userModel.email.text.trim())
      ..subject = 'Verify your email'
      ..html = '''
<div style="font-family: 'Helvetica Neue', Arial, sans-serif; min-width: 1000px; overflow:auto; line-height: 1.6;">
  <div style="margin: 40px auto; width: 80%; padding: 20px; background-color: #f9f9f9; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1);">
    <div style="border-bottom: 1px solid #eee; padding-bottom: 10px; text-align: center;">
      <img src="https://museit.life/wp-content/uploads/2025/11/unnamed-removebg-preview.png" alt="MUSEiT Logo" style="height: 60px; object-fit: contain;">
    </div>
    <div style="padding: 20px;">
      <p style="font-size: 1.2em; color: #333;">Hi,</p>
      <p style="font-size: 1.1em; color: #555;">
        Thank you for signing up to <strong>MUSEiT!</strong> Please use the OTP below to complete your sign-up process.
      </p>
      <div style="text-align: center; margin: 20px 0;">
        <h2 style="background-color: #3089CE; color: #fff; display: inline-block; padding: 10px 20px; border-radius: 5px; font-size: 1.8em;">$verificationCode</h2>
      </div>
      <p style="font-size: 1em; color: #555;">If you did not request this, please ignore this email.</p>
      <p style="font-size: 1em; color: #333;">Best regards,</p>
      <p style="font-size: 1em; font-weight: bold; color: #333;">The MUSEiT Team</p>
    </div>
    <hr style="border:none; border-top:1px solid #eee; margin: 20px 0;">
    <div style="text-align: center; color: #aaa; font-size: 0.9em;">
      <p style="margin: 0;">MUSEiT, Rosemary Cottage The Green, Amport, Andover, England, SP11 8BA</p>
      <p style="margin: 0;">© 2025 MUSEiT. All rights reserved.</p>
    </div>
  </div>
</div>
''';
  }
}
