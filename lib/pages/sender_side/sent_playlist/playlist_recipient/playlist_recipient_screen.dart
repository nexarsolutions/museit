import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/recipients_card.dart';
import '../../../../constants/colors.dart';
import '../../../../widgets/custom_app_bar.dart';
import 'controller/playlist_recipient_controller.dart';

class PlaylistRecipientScreen extends StatelessWidget {
   PlaylistRecipientScreen({super.key});
  final controller = Get.put(PlaylistRecipientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Recipients',isBack: true,),
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
                itemCount: controller.recipientsList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                    },
                    child: RecipientsCard(
                      model: controller.recipientsList[index],
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
