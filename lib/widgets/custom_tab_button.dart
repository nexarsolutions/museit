import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';

class CustomTabButton extends StatelessWidget {
  const CustomTabButton({
    super.key,
    required this.tabNames,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  final List<String> tabNames;
  final int selectedIndex;
  final void Function(int index) onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 45,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Color(0xFF8C7FAC).withValues(alpha: 0.15),
            Color(0xFF7695CA).withValues(alpha: 0.15),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: List.generate(tabNames.length, (index) {
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(index),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),

                  color: selectedIndex == index
                      ? blackColor
                      : Colors.transparent,
                ),
                child: Text(
                  tabNames[index],
                  style: manRopeSemiBold.copyWith(
                    fontSize: 10,
                    color: selectedIndex == index ? whiteColor : darkGrey,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
