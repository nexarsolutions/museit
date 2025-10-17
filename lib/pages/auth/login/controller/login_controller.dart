import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musit/globalModels/user_model.dart';
import 'package:musit/main.dart';
import 'package:musit/pages/auth/login/login_screen.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/utils/global_functions.dart';

import '../../../../services/auth_service.dart';
import '../../../charity_side/charity_home/charity_home/charity_home_screen.dart';
import '../../../recipient_side/home/recipient_home/recipient_home_screen.dart';
import '../../../sender_side/sender_home/sender_home/sender_home_screen.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool showPassword = true.obs;

  final _apiService = ApiService();
  final _authService = AuthService();

  Future<void> login() async {
    await _apiService.handleResponse(
      apiMethod: () => _authService.login(
          email: emailController.text.trim(),
          password: passwordController.text.trim()),
      onSuccess: (response) async {
        customPrint("login success: $response");
        UserModel currentUser = UserModel.fromJson(response['response']);
        await Future.delayed(const Duration(seconds: 1));

        currentUser.currentRoleId == 1
            ? Get.offAll(() => SenderHomeScreen())
            : currentUser.currentRoleId == 2
                ? Get.offAll(() => RecipientHomeScreen())
                : currentUser.currentRoleId == 3
                    ? Get.offAll(() => CharityHomeScreen())
                    : Get.offAll(() => LoginScreen());

        customErrorSnackBar(content: "Logged in successfully");

        userManager.cachedUser = currentUser;
      },
    );
  }
}
