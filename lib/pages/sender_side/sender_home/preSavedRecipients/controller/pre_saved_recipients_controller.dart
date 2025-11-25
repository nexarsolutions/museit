import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PreSavedRecipientsController extends GetxController {
  // final searchController = TextEditingController();
  // final searchQuery = ''.obs;
  final RxBool isLoading = false.obs;
  final RxList<int> selectedUsersId = <int>[].obs;
}
