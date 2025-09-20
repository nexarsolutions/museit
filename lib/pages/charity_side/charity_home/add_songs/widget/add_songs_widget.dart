import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/pages/charity_side/charity_home/add_songs/model/add_songs_model.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/text_styles.dart';

class AddSongsWidget extends StatelessWidget {
  AddSongsWidget({super.key, required this.model});
  final AddSongsModel model;

  // ✅ isSelected ko reactive banaya
  final RxBool isSelected = false.obs;

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

                const SizedBox(width: 12),

                // Name + Plan (left side text)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title,
                        style: manRopeSemiBold.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        model.duration,
                        style: manRope.copyWith(
                          fontSize: 12,
                          color: lightBlack,
                        ),
                      ),
                    ],
                  ),
                ),

                // ✅ Obx lagaya for reactive state
                Obx(() {
                  return isSelected.value
                      ? GestureDetector(
                    onTap: () {
                      isSelected.value = false;
                    },
                    child: Image.asset(
                      'assets/images/tick_purple.png',
                      width: 22,
                      height: 22,
                    ),
                  )
                      : GestureDetector(
                    onTap: () {
                      isSelected.value = true;
                    },
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF8C7FAC).withValues(alpha: 0.15),
                            Color(0xFF7695CA).withValues(alpha: 0.15),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
