import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';

import '../../../../../globalModels/health_support_response_model.dart';

class HealthSupportCard extends StatelessWidget {
  final HealthSupportModel data;

  const HealthSupportCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [whiteColor, blueColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 1, right: 1, bottom: 1),
        child: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 33,
                  backgroundColor: lightGrey,
                  backgroundImage:
                      data.user != null && data.user!.profile.value != ''
                          ? CachedNetworkImageProvider(data.user!.profile.value)
                          : null,
                  child: data.user != null && data.user!.profile.value != ''
                      ? null
                      : Center(
                          child: Text(
                            data.user?.username.text != ''
                                ? data.user?.username.text
                                        .split('')
                                        .first
                                        .toUpperCase() ??
                                    '?'
                                : '?',
                            style: manRopeSemiBold.copyWith(
                              fontSize: 20,
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 8),
                Text(
                  data.user?.username.text != ''
                      ? data.user?.username.text ?? 'Loading...'
                      : 'Loading...',
                  textAlign: TextAlign.center,
                  style: manRopeSemiBold.copyWith(fontSize: 10),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  data.healthTypeName ?? "N/A",
                  textAlign: TextAlign.center,
                  style: manRope.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w200,
                    color: lightBlack,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
