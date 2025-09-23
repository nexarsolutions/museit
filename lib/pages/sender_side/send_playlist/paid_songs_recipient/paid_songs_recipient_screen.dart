import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/sender_side/send_playlist/paid_songs_recipient/controller/paid_songs_recipient_controller.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_text_field.dart';

import '../../../../common_widgets/recipients_card.dart';
import '../../../../widgets/custom_button.dart';
import '../paid_songs_payment_details/paid_songs_payment_details_screen.dart';

class PaidSongsRecipientScreen extends StatelessWidget {
  PaidSongsRecipientScreen({super.key});
  final controller = Get.put(PaidSongsRecipientController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            text: 'Recipients',
            isBack: true,
            showLastIcon: true,
            lastWidget: Image.asset(
              'assets/images/upload_icon_rounded.png',
              scale: 3.5,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  CustomTextField(
                    controller: controller.searchController,
                    hintText: 'Search',
                    isSuffixIcon: true,
                    suffixIcon: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: blackColor,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset('assets/images/search_icon.png', scale: 3),
                    ),
                  ),
                  SizedBox(height: 16),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    padding: EdgeInsets.only(bottom: 30),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 13.0,
                      mainAxisSpacing: 10.0,
                      mainAxisExtent: 150,
                    ),
                    itemCount: controller.recipientsList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: RecipientsCard(
                          model: controller.recipientsList[index],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 42),
                  CustomButton(onPressed: () {
                    Get.to(()=>PaidSongsPaymentDetailsScreen());
                  }, text: 'Proceed'),

                  SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
