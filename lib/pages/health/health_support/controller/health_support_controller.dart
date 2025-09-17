import 'package:get/get.dart';
import 'package:musit/pages/health/health_support/model/health_support_model.dart';

class HealthSupportController extends GetxController {
  List<HealthSupportModel> healthSupportList = [
    HealthSupportModel(
      imagePath: 'assets/images/dummy_rounded_1.png',
      userName: 'Katherine',
      userRole: 'Cancer Treatment',
      healthType: 'Critical',
      disease: 'Cancer',
      monthlyAidGoal: 5000,
      story:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
    ),
    HealthSupportModel(
      imagePath: 'assets/images/dummy_rounded_2.png',
      userName: 'Alex George',
      userRole: 'Cancer Treatment',
      healthType: 'Critical',
      disease: 'Cancer',
      monthlyAidGoal: 2000,
      story:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
    ),
    HealthSupportModel(
      imagePath: 'assets/images/dummy_rounded_3.png',
      userName: 'George',
      userRole: 'Cancer Treatment',
      healthType: 'Critical',
      disease: 'Cancer',
      monthlyAidGoal: 8000,
      story:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
    ),
    HealthSupportModel(
      imagePath: 'assets/images/dummy_rounded_4.png',
      userName: 'George',
      userRole: 'Cancer Treatment',
      healthType: 'Critical',
      disease: 'Cancer',
      monthlyAidGoal: 20000,
      story:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
    ),
    HealthSupportModel(
      imagePath: 'assets/images/dummy_rounded_5.png',
      userName: 'Kathy James',
      userRole: 'Cancer Treatment',
      healthType: 'Critical',
      disease: 'Cancer',
      monthlyAidGoal: 20000,
      story:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
    ),
    HealthSupportModel(
      imagePath: 'assets/images/dummy_rounded_6.png',
      userName: 'J. Lesner',
      userRole: 'Cancer Treatment',
      healthType: 'Critical',
      disease: 'Cancer',
      monthlyAidGoal: 20000,
      story:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
    ),
    HealthSupportModel(
      imagePath: 'assets/images/dummy_rounded_1.png',
      userName: 'Katherine',
      userRole: 'Cancer Treatment',
      healthType: 'Critical',
      disease: 'Cancer',
      monthlyAidGoal: 5000,
      story:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
    ),
    HealthSupportModel(
      imagePath: 'assets/images/dummy_rounded_2.png',
      userName: 'Alex George',
      userRole: 'Cancer Treatment',
      healthType: 'Critical',
      disease: 'Cancer',
      monthlyAidGoal: 2000,
      story:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
    ),
    HealthSupportModel(
      imagePath: 'assets/images/dummy_rounded_3.png',
      userName: 'George',
      userRole: 'Cancer Treatment',
      healthType: 'Critical',
      disease: 'Cancer',
      monthlyAidGoal: 8000,
      story:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
    ),
    HealthSupportModel(
      imagePath: 'assets/images/dummy_rounded_4.png',
      userName: 'George',
      userRole: 'Cancer Treatment',
      healthType: 'Critical',
      disease: 'Cancer',
      monthlyAidGoal: 20000,
      story:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
    ),
    HealthSupportModel(
      imagePath: 'assets/images/dummy_rounded_5.png',
      userName: 'Kathy James',
      userRole: 'Cancer Treatment',
      healthType: 'Critical',
      disease: 'Cancer',
      monthlyAidGoal: 20000,
      story:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
    ),
    HealthSupportModel(
      imagePath: 'assets/images/dummy_rounded_6.png',
      userName: 'J. Lesner',
      userRole: 'Cancer Treatment',
      healthType: 'Critical',
      disease: 'Cancer',
      monthlyAidGoal: 20000,
      story:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
    ),
  ];
}
