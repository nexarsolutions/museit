import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/utils/extensions.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/text_styles.dart';
import '../common_models/saved_playlist_model.dart';
import '../globalModels/playlist_model.dart';

class SavedPlaylistCard extends StatelessWidget {
  const SavedPlaylistCard({
    super.key,
    required this.playlist,
    this.showDateTime = false,
    this.showContainer = false,
  });

  final PlaylistModel playlist;
  final bool showDateTime;
  final bool showContainer;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                    // Profile image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: playlist.image.value.showImage,
                        // Your backend image URL
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.broken_image,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Name + Plan (left side text)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            playlist.title.text.withNa,
                            style: manRopeSemiBold.copyWith(fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            playlist.purposeName.withNa,
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
                                  'Date ${playlist.createdAt.formatDate}',
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
        ),
        Positioned(
          top: 12,
          right: 12,
          child: showContainer == true
              ? Container(
                  width: 8,
                  height: 8,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: blueColor),
                )
              : SizedBox(),
        )
      ],
    );
  }
}
