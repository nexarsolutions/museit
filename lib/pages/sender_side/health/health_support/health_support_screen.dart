import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/sender_side/health/health_support/widget/health_support_card.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import '../../../../constants/text_styles.dart';
import '../health_support_details/health_support_details_screen.dart';
import 'controller/health_support_controller.dart';

class HealthSupportScreen extends StatelessWidget {
  HealthSupportScreen({super.key});

  final controller = Get.put(HealthSupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          const CustomAppBar(text: 'Health Support', isBack: true),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorString.value != null) {
                return Center(
                    child: Text(
                  controller.errorString.value ?? "Something went wrong",
                  style: manRope,
                ));
              }

              if (controller.healthSupportList.isEmpty) {
                return Center(
                    child: Text(
                  'No Health Support Found',
                  style: manRope,
                ));
              }

              return RefreshIndicator(
                onRefresh: () => controller.getHealthSupports(refresh: true),
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (!controller.isLoading.value &&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      controller.getHealthSupports();
                    }
                    return false;
                  },
                  child: GridView.builder(
                    padding: const EdgeInsets.only(bottom: 30),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 13.0,
                      mainAxisSpacing: 10.0,
                      mainAxisExtent: 155,
                    ),
                    itemCount: controller.healthSupportList.length,
                    itemBuilder: (context, index) {
                      final item = controller.healthSupportList[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => HealthSupportDetailsScreen(model: item));
                        },
                        child: HealthSupportCard(data: item),
                      );
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
