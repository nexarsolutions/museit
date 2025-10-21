import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SenderViewRecipientController extends GetxController {
  final searchController = TextEditingController();
  final searchQuery = ''.obs;
  final RxList<int> selectedUsersId = <int>[].obs;
}
