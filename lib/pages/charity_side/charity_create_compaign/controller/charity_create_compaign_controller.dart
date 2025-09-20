import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CharityCreateCompaignController extends GetxController {
  final compaignTitleController = TextEditingController();
  final monthlyAidGoalController = TextEditingController();
  final causeController = TextEditingController();
  final goalAmountController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final accountTitleController = TextEditingController();

  var pickedImagePath = ''.obs;

  final RxString selectedPlaylist = 'Umbrella'.obs;
  final List<String> playlistList = [
    'Umbrella',
    'Sky',
    'Fallen to earth',
    'God Given',
  ];

}
