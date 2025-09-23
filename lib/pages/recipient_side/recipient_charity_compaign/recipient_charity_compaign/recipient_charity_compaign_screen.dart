import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/recipient_side/recipient_charity_compaign/recipient_charity_compaign/controller/recipient_charity_compaign_controller.dart';
import 'package:musit/pages/recipient_side/recipient_charity_compaign/recipient_charity_compaign/widget/charity_compaign_widget.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../view_recipient_charity/view_recipient_charity_compaign_screen.dart';

class RecipientCharityCompaignScreen extends StatelessWidget {
  RecipientCharityCompaignScreen({super.key});
  final controller = Get.put(RecipientCharityCompaignController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Charity Compaigns',isBack: true,),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.only(bottom: 30,left: 16,right: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                mainAxisExtent: 190,
              ),
              itemCount: controller.activeCompaignsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => ViewRecipientCharityCompaignScreen(model: controller.activeCompaignsList[index],));
                    },
                    child: CharityCompaignWidget(
                      model: controller.activeCompaignsList[index],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
