import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';

class CustomDropDown<T> extends StatelessWidget {
  CustomDropDown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.dropdownItems,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.iconColor = blackColor,
    this.maxHeight,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w500,
    this.fontFamily = 'lexend',
    this.validator,
    this.onSaved,
  });

  final T? value;
  final String? hintText;
  final List<T> dropdownItems;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color iconColor;
  final double? maxHeight;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final RxBool isExpanded = false.obs;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;
  final void Function(T?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8C7FAC).withValues(alpha: 0.15),
            const Color(0xFF7695CA).withValues(alpha: 0.15),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(
        () => DropdownButtonFormField2<T>(
          value: value,
          isExpanded: true,
          onMenuStateChange: (isOpen) {
            isExpanded.value = isOpen;
          },
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 5, right: 8),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            errorStyle: const TextStyle(
              height: 0, // hide default error inside field
              color: redColor,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
          validator: validator,
          hint: Text(
            dropdownItems[0].toString(),
            style: TextStyle(
              color: greyColor,
              fontSize: fontSize,
              fontFamily: fontFamily,
              fontWeight: fontWeight,
            ),
          ),
          items: dropdownItems
              .map(
                (T item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    item.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: fontSize,
                      fontFamily: fontFamily,
                      fontWeight: fontWeight,
                    ),
                  ),
                ),
              )
              .toList(),
          iconStyleData: IconStyleData(
            icon: isExpanded.value == false
                ? Icon(Icons.expand_more, color: iconColor)
                : Icon(Icons.expand_less_rounded, color: iconColor),
            iconSize: 28,
          ),
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.zero,
          ),
          dropdownStyleData: DropdownStyleData(
            elevation: 0,
            maxHeight: maxHeight,
            decoration: BoxDecoration(
              color: whiteColor,
              // gradient: LinearGradient(
              //   colors: [
              //     const Color(0xFF8C7FAC).withValues(alpha: 0.15),
              //     const Color(0xFF7695CA).withValues(alpha: 0.15),
              //   ],
              //   begin: Alignment.centerLeft,
              //   end: Alignment.centerRight,
              // ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
