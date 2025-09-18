import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/text_styles.dart';

import '../../../../constants/colors.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key, required this.iconPath, required this.title, required this.onTap, });
  final String iconPath;
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: manRope.copyWith(fontSize: 12, fontWeight: FontWeight.w300,),
                  ),
                ),
                Image.asset(
                  'assets/images/forward_arrow.png',
                  width: 16,
                  height: 16,
                ),
              ],
            ),
            SizedBox(height: 18,),
           Container(
             width: Get.width,
             height: 1,
             decoration: BoxDecoration(
               gradient: LinearGradient(
                 colors: [
                   Color(0xFF8C7FAC).withValues(alpha: 0.3),
                   Color(0xFF7695CA).withValues(alpha: 0.3),
                 ],
                 begin: Alignment.centerLeft,
                 end: Alignment.centerRight,
               ),

             ),
           ),
            SizedBox(height: 12,)
          ],
        ),
      ),
    );
  }
}
