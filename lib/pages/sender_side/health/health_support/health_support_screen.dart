import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/sender_side/health/health_support/widget/health_support_card.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../health_support_details/health_support_details_screen.dart';
import 'controller/health_support_controller.dart';

class HealthSupportScreen extends StatelessWidget {
  const HealthSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HealthSupportController controller = Get.put(
      HealthSupportController(),
    );
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          const CustomAppBar(text: 'Health Support', isBack: true),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: GridView.builder(
                padding: EdgeInsets.only(bottom: 30),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 13.0,
                  mainAxisSpacing: 10.0,
                  mainAxisExtent: 150,
                ),
                itemCount: controller.healthSupportList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => HealthSupportDetailsScreen(
                          model: controller.healthSupportList[index],
                        ),
                      );
                    },
                    child: HealthSupportCard(
                      healthSupportModel: controller.healthSupportList[index],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
