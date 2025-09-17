import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  RxBool showPassword = true.obs;
  RxBool showConfirmPassword = true.obs;

  final RxString skillsValue = 'Add your skill'.obs;
  final List<String> skillsList = [
    'Skill 1',
    'Skill 2',
    'Skill 3',
  ];

  final RxString goalSelection = 'Add Goal'.obs;
  final List<String> goalList = [
    'Information',
    'Skill',
    'Knowledge',
  ];

  final RxList<String> addedGoals = <String>[].obs;
  void addGoal(){
    final selected = goalSelection.value;
    if (selected != 'Add Goal' && !addedGoals.contains(selected)) {
      addedGoals.add(selected);
    }
  }

}
