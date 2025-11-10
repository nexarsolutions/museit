import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/utils/extensions.dart';

// import 'package:shimmer/shimmer.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/text_styles.dart';
import '../../../../../globalModels/song_model.dart';

class AddSongsWidget extends StatelessWidget {
  const AddSongsWidget(
      {super.key,
      required this.song,
      this.onTap,
      required this.isSelected,
      this.showSelected = true});

  final SongModel song;

  final RxBool isSelected;

  final bool showSelected;
  final void Function()? onTap;

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
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border(
                  left: BorderSide(color: blueColor, width: 0.7),
                  right: BorderSide(color: blueColor, width: 0.7),
                  bottom: BorderSide(color: blueColor, width: 0.7),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: song.image.showImage,
                    // Your backend image URL
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Icon(
                        Icons.music_note,
                        color: Colors.black,
                        size: 30,
                      );
                      // return Shimmer.fromColors(
                      //   baseColor: Colors.grey.shade300,
                      //   highlightColor: Colors.grey.shade100,
                      //   child: Container(
                      //     height: 60,
                      //     width: 60,
                      //     color: Colors.grey.shade300,
                      //   ),
                      // );
                    },
                    errorWidget: (context, url, error) {
                      return Icon(
                        Icons.music_note,
                        color: Colors.black,
                        size: 30,
                      );

                      // return Shimmer.fromColors(
                      //   baseColor: Colors.grey.shade300,
                      //   highlightColor: Colors.grey.shade100,
                      //   child: Container(
                      //     height: 60,
                      //     width: 60,
                      //     color: Colors.grey.shade300,
                      //   ),
                      // );
                    },
                  ),
                ),

                const SizedBox(width: 12),

                // Name + Plan (left side text)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.name ?? "N/A",
                        style: manRopeSemiBold.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      /*Text(
                        *//*song.price?.toString() ??*//*
                        'N/A',
                        style: manRope.copyWith(
                          fontSize: 12,
                          color: lightBlack,
                        ),
                      ),*/
                    ],
                  ),
                ),

                if (showSelected)
                  Obx(() {
                    return GestureDetector(
                      onTap: onTap,
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
