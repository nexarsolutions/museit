import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';

class AllRecipientsController extends GetxController {
  final searchQuery = ''.obs;

  final searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final RxnString selectedImage = RxnString();
  final RxnString selectedLogo = RxnString();

  final RxList<int> selectedUsersId = <int>[].obs;
  final List<String> logoList = ['assets/images/app_icon.jpg'];

  Future<void> importContact() async {
    final permission = await FlutterContacts.requestPermission();
    if (!permission) {
      customErrorSnackBar(content: "Please allow contact access from settings");
      return;
    }

    try {
      final contact = await FlutterContacts.openExternalPick();
      if (contact == null) return;

      nameController.text = contact.displayName;
      phoneController.text =
          contact.phones.isNotEmpty ? contact.phones.first.number : '';
      emailController.text =
          contact.emails.isNotEmpty ? contact.emails.first.address : '';
    } catch (e) {
      customErrorSnackBar(content: "Contact error: $e");
    }
  }
}
