import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/widgets/custom_button.dart';

import '../../../../widgets/custom_app_bar.dart';
import '../application/application_screen.dart';

class RecipientHealthSupportScreen extends StatelessWidget {
  const RecipientHealthSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: Get.height * 0.35,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/health_support_background.png',
                      height: Get.height * 0.35,
                      width: Get.width,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: Get.width,
                        height: Get.height * 0.1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0.0),
                              Colors.white,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomAppBar(text: '', isBack: true),
            ],
          ),
          Text(
            'Health Support',
            style: manRopeSemiBold.copyWith(fontSize: 16),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus, quam ac ultricies bibendum, ante ligula elementum dolor, vel pharetra diam nibh non risus. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales. Nam vel mauris nec lacus tempor sodales sit amet in lacus. Donec maximus tempus sodales.',
              style: manRope.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
          Spacer(),
          CustomButton(onPressed: (){
            Get.to(()=>ApplicationScreen());
          }, text: 'Apply for Support'),
          SizedBox(height: 24),

        ],
      ),
    );
  }
}
