import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, this.isBack, required this.title});
  final bool? isBack;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.08),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isBack == true
                      ? GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 5),
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: blackColor,
                            ),
                            child: Image.asset(
                              'assets/images/back_arrow.png',
                              scale: 3.5,
                            ),
                          ),
                        )
                      : SizedBox(width: 44, height: 44),
                  Image.asset('assets/images/museit_icon.png', scale: 3.5),
                  SizedBox(width: 44, height: 44),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(title, style: manRopeSemiBold),
          ],
        ),
      ),
    );
  }
}
