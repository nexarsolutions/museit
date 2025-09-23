import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../common_models/recipients_model.dart';

class PaidSongsRecipientController extends GetxController{
final searchController = TextEditingController();
List<RecipientsModel> recipientsList = [
  RecipientsModel(
    profilePicture: 'assets/images/dummy_rounded_1.png',
    name: 'Katherine',
  ),
  RecipientsModel(
    profilePicture: 'assets/images/dummy_rounded_2.png',
    name: 'Alex George',
  ),
  RecipientsModel(
    profilePicture: 'assets/images/dummy_rounded_3.png',
    name: 'Will Smith',
  ),
  RecipientsModel(
    profilePicture: 'assets/images/dummy_rounded_4.png',
    name: 'Kathy James',
  ),
  RecipientsModel(
    profilePicture: 'assets/images/dummy_rounded_1.png',
    name: 'J. Lesner',
  ),
  RecipientsModel(
    profilePicture: 'assets/images/dummy_rounded_2.png',
    name: 'Peter. W',
  ),
  RecipientsModel(
    profilePicture: 'assets/images/dummy_rounded_3.png',
    name: 'Sara James',
  ),
];

}