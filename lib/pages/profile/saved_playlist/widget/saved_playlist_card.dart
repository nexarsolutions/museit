import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/pages/profile/saved_playlist/model/saved_playlist_model.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_styles.dart';

class SavedPlaylistCard extends StatelessWidget {
  const SavedPlaylistCard({super.key, required this.model});
final SavedPlaylistModel model;
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
                        model.name,
                        style: manRopeSemiBold.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        model.category,
                        style: manRope.copyWith(
                          fontSize: 12,
                          color: lightBlack,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
