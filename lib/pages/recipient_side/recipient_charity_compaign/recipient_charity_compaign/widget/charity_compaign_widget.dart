import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/common_models/recipients_model.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/recipient_side/home/recipient_home/recipient_home_screen.dart';
import 'package:musit/pages/sender_side/subscriptions/payment_details/payment_details_screen.dart';

import '../../../../../common_models/my_compaigns_model.dart';

class CharityCompaignWidget extends StatelessWidget {
  const CharityCompaignWidget({super.key, required this.model});
  final MyCompaignsModel model;

  @override
  Widget build(BuildContext context) {
    // Calculate the progress value (0.0 to 1.0)
    final double progressValue = model.currentPrice / model.GoalPrice;

    // Outer Container for the gradient border.
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // This is the gradient that acts as the border.
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFFFFF), // White at the top
            Color(0xFF561F6C), // Dark at the bottom
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      // The Padding widget creates the visible thickness of the border.
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 1, bottom: 1),
        child: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(
              16,
            ), // Outer radius (16) - Padding (2) = 14
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 121,
                  width: Get.width,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(model.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      // Make progress bar here
                      LinearProgressIndicator(
                        value: progressValue,
                        backgroundColor: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          blackColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.compaignName,
                                  textAlign: TextAlign.center,
                                  style: manRopeSemiBold.copyWith(fontSize: 10),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Goal \$${model.GoalPrice.toString()}',
                                  textAlign: TextAlign.center,
                                  style: manRope.copyWith(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(
                                () => PaymentDetailsScreen(
                                  isSender: false,
                                  confirmOnTap: () {
                                    Get.offAll(() => RecipientHomeScreen());
                                  },
                                ),
                              );
                            },
                            child: Container(
                              width: 60,
                              height: 25,
                              decoration: BoxDecoration(
                                color: blackColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  'Donate',
                                  style: manRopeSemiBold.copyWith(
                                    fontSize: 8,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
