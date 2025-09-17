import 'package:flutter/material.dart';
import 'package:musit/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController controller;
  final String? labelText;
  final FontWeight? fontWeight;
  final bool isSuffixIcon;
  final bool isPrefixIcon;
  final String hintText;
  final double borderRadius;
  final double borderWidth;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool enabled;
  final double fontSize;
  final String? fontFamily;
  final int? maxLines;
  final Color? labelColor;
  final Color? hintColor;
  final Color? borderColor;
  final Color? textColor;
  final bool isBorder;
  final bool isShadow;
  final double elevation;
  final String? suffixText;
  final void Function(String)? onChanged;
  final TextAlign textAlign;
  final TextStyle? hintStyle;
  final void Function()? onTap;
  final bool readOnly;
  final bool autofocus;
  final EdgeInsets? contentPadding;

  const CustomTextField({
    super.key,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    required this.controller,
    this.labelText,
    this.enabled = true,
    this.maxLines = 1,
    required this.hintText,
    this.borderRadius = 12,
    this.borderWidth = 1,
    this.fontWeight = FontWeight.w400,
    this.suffixIcon,
    this.fontSize = 12,
    this.fontFamily = 'ManropeSemiBold',
    this.isSuffixIcon = true,
    this.labelColor,
    this.hintColor = lightGrey,
    this.borderColor = Colors.transparent,
    this.textColor = blackColor,
    this.isPrefixIcon = false,
    this.prefixIcon,
    this.isBorder = false,
    this.isShadow = false,
    this.elevation = 0,
    this.suffixText,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.hintStyle,
    this.onTap,
    this.readOnly = false,
    this.autofocus = false,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF8C7FAC).withValues(alpha: 0.15),
                    Color(0xFF7695CA).withValues(alpha: 0.15),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                border: isBorder == true
                    ? Border.all(color: borderColor!, width: borderWidth)
                    : const Border.fromBorderSide(BorderSide.none),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: TextFormField(
                cursorColor: blackColor,
                autofocus: autofocus,
                readOnly: readOnly,
                onTap: onTap,
                textAlign: textAlign,
                onChanged: (val) {
                  state.didChange(val);
                  if (onChanged != null) onChanged!(val);
                },
                maxLines: maxLines,
                obscuringCharacter: '∗',
                keyboardType: keyboardType,
                obscureText: obscureText,
                controller: controller,
                style: TextStyle(
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                  fontFamily: fontFamily,
                  color: textColor,
                ),
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  enabled: enabled,
                  fillColor: Colors.transparent,
                  filled: true,
                  contentPadding: contentPadding ??
                      const EdgeInsets.only(left: 16, top: 0, bottom: 0, right: 8),
                  suffixText: suffixText,
                  suffixStyle: TextStyle(
                    fontWeight: fontWeight,
                    fontSize: fontSize,
                    fontFamily: fontFamily,
                    color: hintColor,
                  ),
                  labelText: labelText,
                  labelStyle: TextStyle(
                    fontWeight: fontWeight,
                    fontSize: fontSize,
                    fontFamily: fontFamily,
                    color: labelColor,
                  ),
                  hintText: hintText,
                  hintStyle: hintStyle ??
                      TextStyle(
                        fontWeight: fontWeight,
                        fontSize: fontSize,
                        fontFamily: fontFamily,
                        color: hintColor,
                      ),
                  suffixIcon: isSuffixIcon ? suffixIcon : null,
                  prefixIcon: isPrefixIcon ? prefixIcon : null,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  // hide default error inside TextField
                  errorStyle: const TextStyle(height: 0, color: Colors.transparent),
                ),
              ),
            ),
            if (state.hasError) ...[
              const SizedBox(height: 5),
              Text(
                state.errorText ?? '',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
