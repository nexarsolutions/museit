import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';

class CustomDropDown extends StatelessWidget {
  final RxBool isExpanded = false.obs;

  CustomDropDown({
    super.key,
    this.onChanged,
    required this.dropdownItems,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.iconColor = blackColor,
    this.maxHeight,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w500,
    this.fontFamily = 'lexend',
    this.validator,
  });

  final String hintText;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color iconColor;
  final double? maxHeight;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final String? Function(String?)? validator;

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
                    const Color(0xFF8C7FAC).withValues(alpha: 0.15),
                    const Color(0xFF7695CA).withValues(alpha: 0.15),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Obx(
                    () => DropdownButtonFormField2<String>(
                  value: null,
                  isExpanded: true,
                  onMenuStateChange: (isOpen) {
                    isExpanded.value = isOpen;
                  },
                  onChanged: (val) {
                    state.didChange(val);
                    if (onChanged != null) onChanged!(val);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 16, right: 8),
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
                      color: Colors.transparent,
                    ),
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon,
                  ),
                  hint: Text(
                    hintText,
                    style: TextStyle(
                      color: greyColor,
                      fontSize: fontSize,
                      fontFamily: fontFamily,
                      fontWeight: fontWeight,
                    ),
                  ),
                  items: dropdownItems
                      .map(
                        (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
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
