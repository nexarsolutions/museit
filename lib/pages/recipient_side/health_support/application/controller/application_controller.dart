import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ApplicationController extends GetxController{
  final RxString selectedHealthType = 'Health Type 1'.obs;
  final List<String> healthTypeList = [
    'Health Type 1',
    'Health Type 2',
    'Health Type 3',
    'Health Type 4',
  ];
  final diseaseController = TextEditingController();
  final monthlyAidGoalController = TextEditingController();
  final storyController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final accountTitleController = TextEditingController();

  var pickedImagePath = ''.obs;


}