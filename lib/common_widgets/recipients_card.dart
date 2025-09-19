import 'package:flutter/material.dart';
import 'package:musit/common_models/recipients_model.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';


class RecipientsCard extends StatelessWidget {
  final RecipientsModel model;

  const RecipientsCard({
    super.key,
    required this.model,
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
                  backgroundImage: AssetImage(model.profilePicture),
                ),
                const SizedBox(height: 8),
                Text(
                  model.name,
                  textAlign: TextAlign.center,
                  style: manRopeSemiBold.copyWith(
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}