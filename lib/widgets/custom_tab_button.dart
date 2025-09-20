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




class CustomTabButtonWithIcon extends StatelessWidget {
  const CustomTabButtonWithIcon({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  /// Each tab will have:
  /// - title
  /// - selected icon
  /// - unselected icon
  final List<TabItem> tabs;
  final int selectedIndex;
  final void Function(int index) onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 45,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8C7FAC).withValues(alpha: 0.15),
            const Color(0xFF7695CA).withValues(alpha: 0.15),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final tab = tabs[index];
          final bool isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(index),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isSelected ? blackColor : Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      isSelected ? tab.selectedIcon : tab.unselectedIcon,
                      width: 16,
                      height: 16,
                      color: isSelected ? whiteColor : darkGrey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      tab.title,
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
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Model class for tab item
class TabItem {
  final String title;
  final String selectedIcon;
  final String unselectedIcon;

  TabItem({
    required this.title,
    required this.selectedIcon,
    required this.unselectedIcon,
  });
}
