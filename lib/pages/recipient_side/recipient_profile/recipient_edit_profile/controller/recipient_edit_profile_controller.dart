import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RecipientEditProfileController extends GetxController{
  RxString imagePath = ''.obs;
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  ///change password bottomsheet
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isCurrentPasswordHidden = true.obs;
  var isNewPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

}