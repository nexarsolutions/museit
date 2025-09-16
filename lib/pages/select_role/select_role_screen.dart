import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/widgets/custom_button.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';

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
                    // Corrected the gradient direction and colors
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(
                          0.0,
                        ), // Starts fully transparent
                        Colors.white, // Fades to solid white
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 23),
          Text('Select Role', style: manRopeSemiBold),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              'Motivation moves in two ways, will you send it or receive it?',
              style: manRopeSemiBold.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24),
          CustomButton(onPressed: (){}, text: 'Sender')

        ],
      ),
    );
  }
}
