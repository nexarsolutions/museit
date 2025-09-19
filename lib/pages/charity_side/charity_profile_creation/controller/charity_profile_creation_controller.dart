import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CharityProfileCreationController extends GetxController {
  final RxInt isSelected = 0.obs;
  final organizationNameController = TextEditingController();
  final addressController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final accountTitleController = TextEditingController();
  final ifOfOwnerController = TextEditingController();
  var pickedImagePath = ''.obs;

}
