import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/text_styles.dart';
import '../common_models/saved_playlist_model.dart';

class SavedPlaylistCard extends StatelessWidget {
  const SavedPlaylistCard({
    super.key,
    required this.model,
    this.showDateTime = false,
  });
  final SavedPlaylistModel model;
  final bool showDateTime;

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
                const SizedBox(width: 12),
                showDateTime
                    ? Column(
                        children: [
                          SizedBox(height: 24),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'Date 20-05-2025',
                              style: manRopeSemiBold.copyWith(fontSize: 8),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
