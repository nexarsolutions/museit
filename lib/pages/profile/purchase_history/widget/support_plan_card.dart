import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_styles.dart';
import '../model/support_plan_model.dart';

class SupportPlanCard extends StatelessWidget {
  const SupportPlanCard({super.key, required this.model});
final SupportPlanModel model;
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
                  left: BorderSide(
                    color: purpleColor,
                    width: 0.7,
                  ),

                  right: BorderSide(
                    color: purpleColor,
                    width: 0.7,
                  ),
                  bottom: BorderSide(
                    color: purpleColor,
                    width: 0.7,
                  ),
                  // top ko intentionally blank rakha
                ),
              ),
            ),
          ),

          // ✅ Content of card
          Padding(
            padding: const EdgeInsets.only(left: 6,right: 20,top: 6,bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    model.profilePicture,
                    width: 60,
                    height: 60,
                    fit: BoxFit.fill,
                  ),
                ),

                const SizedBox(width: 12),

                // Name + Plan (left side text)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        style: manRopeSemiBold.copyWith(fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Plan ${model.planSubscribed.toString()}',
                        style: manRope.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w200,
                          color: lightBlack,
                        ),
                      ),
                    ],
                  ),
                ),

                // Price + Date (right side text)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${model.price.toString()}',
                      style: manRopeSemiBold.copyWith(fontSize: 10),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      model.date,
                      style: manRope.copyWith(
                        fontSize: 8,
                        fontWeight: FontWeight.w200,
                        color: lightBlack,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
