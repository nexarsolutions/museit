import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/globalModels/song_model.dart';
import 'package:musit/utils/extensions.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/text_styles.dart';

class PaidSongsWidget extends StatelessWidget {
  const PaidSongsWidget({super.key, required this.model});

  final SongModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // This is the gradient that acts as the border.
        gradient: const LinearGradient(
          colors: [
            whiteColor, // White at the top
            blueColor, // Dark at the bottom
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
                // Profile image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: '' /*model.image.showImage*/,
                    // Your backend image URL
                    height: 87,
                    fit: BoxFit.fill,
                    placeholder: (context, url) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 87,
                          width: double.maxFinite,
                          color: Colors.grey.shade300,
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 87,
                          width: double.maxFinite,
                          color: Colors.grey.shade300,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  model.name ?? "N/A",
                  textAlign: TextAlign.center,
                  style: manRopeSemiBold.copyWith(fontSize: 10),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  'Price £${/*model.price ?? 'N/A'*/''}',
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
