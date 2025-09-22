import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/common_sections/notifications/widget/notifications_widget.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import 'controller/notifications_controller.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final controller = Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Notifications', isBack: true),

          /// ✅ Expanded ko Column ke andar rakha
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 30),
                itemCount: controller.notificationsList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: NotificationsWidget(
                      model: controller.notificationsList[index],
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
