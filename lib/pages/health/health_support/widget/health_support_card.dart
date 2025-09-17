import 'package:flutter/material.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/health/health_support/model/health_support_model.dart';

class HealthSupportCard extends StatelessWidget {
  final HealthSupportModel healthSupportModel;

  const HealthSupportCard({
    super.key,
    required this.healthSupportModel,
  });

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.only(left: 1, right: 1, bottom: 1),
        child: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(16), // Outer radius (16) - Padding (2) = 14
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: lightGrey,
                  backgroundImage: AssetImage(healthSupportModel.imagePath),
                ),
                const SizedBox(height: 8),
                Text(
                  healthSupportModel.userName,
                  textAlign: TextAlign.center,
                  style: manRopeSemiBold.copyWith(
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  healthSupportModel.userRole,
                  textAlign: TextAlign.center,
                  style: manRope.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w200,
                    color: lightBlack,
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