import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/charity_side/charity_home/charity_donations/controller/charity_donations_controller.dart';
import 'package:musit/pages/charity_side/charity_home/charity_donations/widget/donations_widget.dart';
import 'package:musit/widgets/custom_app_bar.dart';

class CharityDonationsScreen extends StatelessWidget {
  CharityDonationsScreen({super.key});
  final controller = Get.put(CharityDonationsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Donations', isBack: true),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 0),
              itemCount: controller.donationsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 12),
                  child: DonationsWidget(model: controller.donationsList[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
