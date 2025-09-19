import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CharityLoginController extends GetxController{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool showPassword = false.obs;
}