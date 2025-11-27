import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../globalModels/presaved_receipents.dart';

class PreSavedRecipientsController extends GetxController {
  // final searchController = TextEditingController();
  // final searchQuery = ''.obs;
  final RxBool isLoading = false.obs;
  final RxList<PreSavedRecipient> selectedUsersId = <PreSavedRecipient>[].obs;
}
