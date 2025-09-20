import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CharityCreatePlaylistController extends GetxController{
  final playlistTitleController = TextEditingController();
  final RxString selectedPurpose = 'Purpose 1'.obs;
  final List<String> purposeList = [
    'Purpose 1',
    'Purpose 2',
    'Purpose 3',
    'Purpose 4',
  ];
  var pickedImagePath = ''.obs;


}