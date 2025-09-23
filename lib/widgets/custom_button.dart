
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final double? width;
  final String text;
  final double fontSize;
  final double? height;
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;
  final FontWeight? fontWeight;
  final Color? backgroundColor;
  final Color? textColor;
  final double? elevation;
  final bool isBorder;
  final bool isSuffixIcon;
  final String? suffixIcon;
  final bool isPrefixIcon;
  final String? prefixIcon;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final String? fontFamily;
  final Color borderColor;
  final double? borderWidth;
  final double? suffixIconSize;
  final bool showWidget;
  final Widget? widget;

  const CustomButton({
    super.key,
    required this.onPressed,
    this.width,
    this.height = 50,
    required this.text,
    this.fontSize = 14,
    this.horizontalPadding = 8,
    this.verticalPadding = 8,
    this.borderRadius = 16,
    this.fontWeight = FontWeight.w500,
    this.backgroundColor = blackColor,
    this.textColor = whiteColor,
    this.elevation = 0,
    this.isBorder = false,
    this.isSuffixIcon = false,
    this.suffixIcon,
    this.isPrefixIcon = false,
    this.showWidget = false,
    this.widget,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixIconColor,
    this.fontFamily = 'ManropeSemiBold',
    this.borderColor = Colors.transparent,
    this.borderWidth,
    this.suffixIconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 1,
          right: 1,
          bottom: -3,
          child: Container(
            height: 30,
            width: 218,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              color: purpleColor,
            ),
          ),
        ),
        SizedBox(
          height: height,
          width: width ?? 220,
          child: MaterialButton(
            onPressed: onPressed,
            elevation: elevation,
            height: height,
            shape: RoundedRectangleBorder(
              side: isBorder == true
                  ? BorderSide(
                      color: borderColor,
                      width: borderWidth ?? 2,
                    )
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            color: backgroundColor,
            minWidth: width,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isPrefixIcon == true && prefixIcon != null)
                  Image.asset(
                    prefixIcon!,
                    height: 24,
                    width: 24,
                    color: prefixIconColor,
                  ),
                // if (isPrefixIcon == true && prefixIcon != null)
                  const SizedBox(width: 12),
                showWidget == true
                    ? Container(
                        child: widget,
                      )
                    : Text(
                        text,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: fontWeight,
                          fontFamily: fontFamily,
                          color: textColor,
                        ),
                      ),
                // if (isSuffixIcon == true && suffixIcon != null)
                  const SizedBox(width: 12),
                if (isSuffixIcon == true && suffixIcon != null)
                  Image.asset(
                    suffixIcon!,
                    height: 24,
                    width: 24,
                    color: suffixIconColor,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
