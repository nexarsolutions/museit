import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/text_styles.dart';

class BuildSelectedItemWidget extends StatelessWidget {
  final String title;
  final String selectedIcon;
  final String unselectedIcon;
  final Color? selectedColor;
  final int index;
  final RxInt selectedIndex;

  const BuildSelectedItemWidget({
    super.key,
    required this.title,
    required this.selectedIcon,
    required this.unselectedIcon,
    this.selectedColor,
    required this.index,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => selectedIndex.value = index,
        child: Obx(
          () {
            final isSelected = selectedIndex.value == index;
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isSelected
                      ? selectedColor ?? blackColor
                      : Colors.transparent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    isSelected ? selectedIcon : unselectedIcon,
                    width: 16,
                    height: 16,
                    color: isSelected ? whiteColor : darkGrey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: manRopeSemiBold.copyWith(
                      fontSize: 10,
                      color: isSelected ? whiteColor : darkGrey,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
