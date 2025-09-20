import 'package:get/get.dart';
import 'package:musit/pages/charity_side/charity_home/charity_donations/model/donations_model.dart';

class CharityDonationsController extends GetxController{
  List <DonationsModel> donationsList = [
    DonationsModel(imagePath: 'assets/images/thumbnail_1.png', name: 'Katherine', donation: 500),
    DonationsModel(imagePath: 'assets/images/thumbnail_2.png', name: 'Katherine', donation: 500),
    DonationsModel(imagePath: 'assets/images/thumbnail_3.png', name: 'Katherine', donation: 500),
    DonationsModel(imagePath: 'assets/images/thumbnail_4.png', name: 'Katherine', donation: 500),
    DonationsModel(imagePath: 'assets/images/thumbnail_5.png', name: 'Katherine', donation: 500),
    DonationsModel(imagePath: 'assets/images/thumbnail_6.png', name: 'Katherine', donation: 500),
  ];
}