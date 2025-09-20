import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/text_styles.dart';
import '../model/donations_model.dart';

class DonationsWidget extends StatelessWidget {
  const DonationsWidget({
    super.key,
    required this.model,
  });
  final DonationsModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // ✅ Custom Borders banane ke liye Positioned widgets
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border(
                  left: BorderSide(color: purpleColor, width: 0.7),

                  right: BorderSide(color: purpleColor, width: 0.7),
                  bottom: BorderSide(color: purpleColor, width: 0.7),
                  // top ko intentionally blank rakha
                ),
              ),
            ),
          ),

          // ✅ Content of card
          Padding(
            padding: const EdgeInsets.only(
              left: 6,
              right: 20,
              top: 6,
              bottom: 6,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    model.imagePath,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 20),

                // Name + Plan (left side text)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        style: manRopeSemiBold.copyWith(fontSize: 12,fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Donate ${model.donation.toString()}',
                        style: manRope.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w200,
                          color: lightBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Image.asset('assets/images/like_icon.png',width: 40,height: 40,),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
