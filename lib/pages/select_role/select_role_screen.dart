import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/select_role_background.png',
                height: Get.height * 0.5,
                width: Get.width,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.15,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [whiteColor, blackColor]),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
