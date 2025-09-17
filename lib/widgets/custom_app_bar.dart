import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final String? image;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color textColor;
  final TextAlign? textAlign;
  final bool isBack;
  final bool showLastIcon;
  final Widget? lastWidget;
  final bool hideColor;
  final VoidCallback? onTap;
  final String? fontFamily;
  final double? topAppBarPadding;
  final double? leftAppBarPadding;
  final double? rightAppBarPadding;
  final double? bottomAppBarPadding;
  final double? appBarContainerHeight;
  final double centerPadding;
  final Color? backArrowColor;
  final Color? backGroundColor;
  final bool showFirstWidget;
  final Widget? firstWidget;
  final Widget? centerWidget;

  const CustomAppBar({
    super.key,
    required this.text,
    this.image,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    this.textColor = blackColor,
    this.textAlign = TextAlign.center,
    this.isBack = false,
    this.showLastIcon = false,
    this.lastWidget,
    this.hideColor = false,
    this.onTap,
    this.fontFamily = 'ManropeSemiBold',
    this.topAppBarPadding,
    this.appBarContainerHeight,
    this.leftAppBarPadding,
    this.rightAppBarPadding,
    this.bottomAppBarPadding,
    this.centerPadding = 0,
    this.backArrowColor,
    this.backGroundColor,
    this.showFirstWidget = false,
    this.firstWidget,
    this.centerWidget,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      height: appBarContainerHeight ?? 110,
      padding: Platform.isAndroid
          ? EdgeInsets.only(
              top: topAppBarPadding ?? 30,
              left: leftAppBarPadding ?? 16,
              right: rightAppBarPadding ?? 16,
              bottom: bottomAppBarPadding ?? 0,
            )
          : EdgeInsets.only(
              top: topAppBarPadding ?? 40,
              left: leftAppBarPadding ?? 16,
              right: rightAppBarPadding ?? 16,
              bottom: bottomAppBarPadding ?? 0,
            ),
      decoration: BoxDecoration(
        color: hideColor ? Colors.transparent : backGroundColor,
      ),

      // 1) Stack holds your original Row (only LEFT+RIGHT)...
      child: Stack(
        children: [
          // A) original side‐widget Row WITHOUT the Expanded text
// A) original side‐widget Row, now centered vertically
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ← exactly your 'firstWidget' / back logic
                showFirstWidget
                    ? firstWidget!
                    : isBack
                        ? GestureDetector(
                            onTap: onTap ?? () => Get.back(),
                            child: Container(
                              height: 44,
                              width: 44,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: blackColor,
                              ),
                              child: Image.asset(
                                'assets/images/back_arrow.png',
                                scale: 3.5,
                              ),
                            ),
                          )
                        : const SizedBox(width: 36, height: 36),

                // → exactly your 'lastWidget' logic
                showLastIcon ? lastWidget! : const SizedBox(width: 36, height: 36),
              ],
            ),
          ),

          // B) and then the title CENTERED on top of that Row
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: centerWidget ??
                  Padding(
                    padding: EdgeInsets.only(left: centerPadding),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: textColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: textAlign,
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  // So you can still use `Scaffold(appBar: CustomAppBar(...))`
  @override
  Size get preferredSize => Size.fromHeight(appBarContainerHeight ?? 110);
}
