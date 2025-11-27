import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/globalModels/song_model.dart';
import 'package:shimmer/shimmer.dart'; // ✅ updated import

class SongCard extends StatelessWidget {
  const SongCard({
    super.key,
    required this.model,
    this.lastWidget,
    this.index,
  });

  final SongModel model;

  final Widget? lastWidget;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
      // key: ValueKey(model.id), // ✅ needed for reorder
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
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border(
                  left: BorderSide(color: blueColor, width: 0.7),
                  right: BorderSide(color: blueColor, width: 0.7),
                  bottom: BorderSide(color: blueColor, width: 0.7),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ✅ Image from network or placeholder
                // 🖼 Image with shimmer placeholder
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _buildImageWithShimmer(model.image),
                ),

                const SizedBox(width: 12),

                // ✅ Song name + optional type
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        /* model.paidSong != null
                            ? model.paidSong?.name ?? "Unknown Song"
                            :*/
                        model.name ?? "Unknown Song",
                        style: manRopeSemiBold.copyWith(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        model.typeId == 1
                            ? "Spotify"
                            : model.typeId == 2
                                ? "Youtube "
                                    "Music"
                                : model.typeId == 3
                                    ? "Apple Music"
                                    : "Custom Song",
                        style: manRope.copyWith(
                          fontSize: 12,
                          color: lightBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                lastWidget ?? const SizedBox.shrink()
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Helper: build shimmer fallback for network image
  Widget _buildImageWithShimmer(String? imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      height: 60,
      width: 60,
      placeholder: (context, url) => Image.asset('assets/images/app_icon.jpg'),
      errorWidget: (context, url, error) =>
          Image.asset('assets/images/app_icon.jpg'),
    );
    return Image.network(
      imageUrl ?? '',
      width: 60,
      height: 60,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildShimmerPlaceholder();
      },
      errorBuilder: (context, error, stackTrace) {
        return _buildShimmerPlaceholder();
      },
    );
  }

  // ✅ Reusable shimmer placeholder
  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 60,
        height: 60,
        color: Colors.grey.shade300,
      ),
    );
  }
}
