import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class AllRecipientsController extends GetxController {
  final searchQuery = ''.obs;

  final searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final RxList<int> selectedUsersId = <int>[].obs;

  Future<void> importContact() async {
    print("************* 0asdfsadf");
    print(await FlutterContacts.requestPermission());
    if (await FlutterContacts.requestPermission()) {
      print("************* 0");
      final contact = await FlutterContacts.openExternalPick();
      print("************* 1");

      if (contact != null) {
        print("************* 2");
        nameController.text = contact.displayName;

        phoneController.text =
            contact.phones.isNotEmpty ? contact.phones.first.number : '';

        emailController.text =
            contact.emails.isNotEmpty ? contact.emails.first.address : '';
      }
    }
  }
}
