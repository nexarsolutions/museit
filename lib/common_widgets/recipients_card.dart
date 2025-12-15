import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/globalModels/user_model.dart';
import 'package:musit/utils/extensions.dart';

import '../services/api_service.dart';

class RecipientsCard extends StatelessWidget {
  final UserModel user;
  final bool isSelected;
  final void Function()? onTap;
  final bool showDonate;
  final bool showPopup;
  final void Function()? onEdit;

  const RecipientsCard({
    super.key,
    required this.user,
    required this.isSelected,
    this.onTap,
    this.showDonate = false,
    this.showPopup = false,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    // Outer Container for the gradient border.
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
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
            padding: const EdgeInsets.only(left: 1, right: 1, bottom: 1),
            // The Padding widget creates the visible thickness of the border.
            child: Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(
                    16), // Outer radius (16) - Padding (2) = 14
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: lightGrey,
                    backgroundImage: user.profile.value != ''
                        ? CachedNetworkImageProvider(
                            user.profile.value.showImage)
                        : null,
                    child: user.profile.value != ''
                        ? null
                        : Center(
                            child: Text(
                              user.username.text != ''
                                  ? user.username.text.split('').first
                                  : '?',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: blackColor,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.username.text != ''
                        ? user.username.text
                        : 'Loading...',
                    textAlign: TextAlign.center,
                    style: manRopeSemiBold.copyWith(
                      fontSize: 10,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (showPopup) ...[
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 16,
                        width: 16,
                        child: PopupMenuButton<_RecipientAction>(
                          padding: EdgeInsets.zero,
                          elevation: 8,
                          color: whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          icon: const Icon(
                            Icons.more_horiz,
                            size: 16,
                            color: blackColor,
                          ),
                          onSelected: (value) {
                            switch (value) {
                              case _RecipientAction.edit:
                                onEdit?.call();
                                break;
                              default:
                                break;
                            }
                          },
                          itemBuilder: (context) => [
                            _buildPopupItem(
                              icon: Icons.edit,
                              text: "Edit",
                              value: _RecipientAction.edit,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  if (showDonate) ...{
                    const SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: blackColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        "Donate",
                        textAlign: TextAlign.center,
                        style: manRope.copyWith(fontSize: 8, color: whiteColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  },
                ],
              ),
            ),
          ),
          isSelected
              ? Image.asset(
                  'assets/images/tick_purple.png',
                  width: 22,
                  height: 22,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  PopupMenuItem<_RecipientAction> _buildPopupItem({
    required IconData icon,
    required String text,
    required _RecipientAction value,
    bool isDanger = false,
  }) {
    return PopupMenuItem<_RecipientAction>(
      value: value,
      height: 40,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isDanger ? Colors.redAccent : blackColor,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: manRope.copyWith(
              fontSize: 12,
              color: isDanger ? Colors.redAccent : blackColor,
            ),
          ),
        ],
      ),
    );
  }
}

enum _RecipientAction {
  edit,
  remove,
}
