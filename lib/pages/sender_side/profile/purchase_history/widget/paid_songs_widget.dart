import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/text_styles.dart';
import '../model/paid_songs_model.dart';


class PaidSongsWidget extends StatelessWidget {
  const PaidSongsWidget({super.key, required this.model});
  final PaidSongsModel model;
  @override
  Widget build(BuildContext context) {
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
          width: Get.width,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 87,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(model.imagePath, fit: BoxFit.fill),
                ),
                const SizedBox(height: 6),
                Text(
                  model.songTitle,
                  textAlign: TextAlign.center,
                  style: manRopeSemiBold.copyWith(fontSize: 10),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  'Price \$${model.songPrice.toString()}',
                  textAlign: TextAlign.center,
                  style: manRope.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w200,
                    color: lightBlack,
                  ),
                ),
                const SizedBox(height: 8),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
