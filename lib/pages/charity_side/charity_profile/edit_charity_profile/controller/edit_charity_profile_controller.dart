import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCharityProfileController extends GetxController{
  final organizationNameController = TextEditingController();
  final addressController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final accountTitleController = TextEditingController();
  final ifOfOwnerController = TextEditingController();
  var pickedImagePath = ''.obs;

}