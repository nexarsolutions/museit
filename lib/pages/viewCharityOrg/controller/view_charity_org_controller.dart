import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ViewCharityOrgController extends GetxController {
  final searchController = TextEditingController();
  final searchQuery = ''.obs;
  final RxnInt selectedCharity = RxnInt();
}
