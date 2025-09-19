import 'package:get/get.dart';

import '../model/paid_songs_model.dart';
import '../model/support_plan_model.dart';

class PurchaseHistoryController extends GetxController {
  var selectedTab = 0.obs;
  List<SupportPlanModel> supportPlanList = [
    SupportPlanModel(
      profilePicture: 'assets/images/patient_1.png',
      name: 'Alex George',
      planSubscribed: 1,
      price: 10,
      date: '20-05-2025',
      disease: 'Cancer',
      monthlyAidGoal: 5000.00,
      healthType: 'Critical',
      story: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.'
    ),
    SupportPlanModel(
      profilePicture: 'assets/images/patient_2.png',
      name: 'Kathy James',
      planSubscribed: 1,
      price: 10,
      date: '20-05-2025',
        disease: 'Cancer',
        monthlyAidGoal: 5000.00,
        healthType: 'Critical',
        story: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.'


    ),
    SupportPlanModel(
      profilePicture: 'assets/images/patient_3.png',
      name: 'Sara James',
      planSubscribed: 1,
      price: 10,
      date: '20-05-2025',
        disease: 'Cancer',
        monthlyAidGoal: 5000.00,
        healthType: 'Critical',
        story: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.'


    ),
    SupportPlanModel(
      profilePicture: 'assets/images/patient_4.png',
      name: 'Peter. W',
      planSubscribed: 1,
      price: 10,
      date: '20-05-2025',
        disease: 'Cancer',
        monthlyAidGoal: 5000.00,
        healthType: 'Critical',
        story: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.'


    ),
  ];

  List <PaidSongsModel> paidSongsList = [
    PaidSongsModel(imagePath: 'assets/images/thumbnail_1.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_2.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_3.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_4.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_5.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_6.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_1.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_2.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_3.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_4.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_5.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_6.png', songTitle: 'Built to Rise', songPrice: 25),
  ];
}
