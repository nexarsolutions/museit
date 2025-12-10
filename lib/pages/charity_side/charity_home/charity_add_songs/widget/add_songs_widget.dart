import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/utils/extensions.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/text_styles.dart';
import '../../../../../globalModels/song_model.dart';

class AddSongsWidget extends StatelessWidget {
  const AddSongsWidget({
    super.key,
    required this.song,
    this.onTap,
    required this.isSelected,
    this.showSelected = true,
  });

  final SongModel song;
  final RxBool isSelected;
  final bool showSelected;
  final VoidCallback? onTap;

  static const _placeholderIcon = Icon(
    Icons.music_note,
    color: Colors.black,
    size: 30,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 6),
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
        border: Border.all(color: blueColor, width: 0.7),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6)
            .copyWith(right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: song.image.showImage,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                placeholder: (_, __) => _placeholderIcon,
                errorWidget: (_, __, ___) => _placeholderIcon,
              ),
            ),

            const SizedBox(width: 12),

            /// Song Text
            Expanded(
              child: Text(
                song.name ?? "N/A",
                style: manRopeSemiBold.copyWith(fontSize: 14),
              ),
            ),

            /// Selection Circle
            if (showSelected)
              Obx(
                    () => GestureDetector(
                  onTap: onTap,
                  behavior: HitTestBehavior.translucent,
                  child: Padding(
                    padding: const EdgeInsets.all(6), // bigger tap area
                    child: isSelected.value
                        ? Image.asset(
                      'assets/images/tick_purple.png',
                      width: 22,
                      height: 22,
                    )
                        : Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF8C7FAC).withValues(alpha: 0.15),
                            const Color(0xFF7695CA).withValues(alpha: 0.15),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
