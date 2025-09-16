import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          SizedBox(height: 50),
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/images/profile_1.png'),
              ),
              SizedBox(width: 10),
              Text('Hi, Katherine!', style: manRopeSemiBold),
              Spacer(),
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: blackColor,
                ),
                child: Image.asset('assets/images/notification.png', scale: 4),
              ),
            ],
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  width: Get.width,
                  padding: EdgeInsets.only(left: 16, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color:lightWhite,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: darkGrey.withValues(alpha: 0.05)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/left_comma.png',
                              height: 14,
                              width: 14,
                            ),
                            SizedBox(height: 3),
                            Text(
                              "Because everyone needs a soundtrack to rise, to heal, to fight, to feel alive again",
                              style: manRope.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                'assets/images/right_comma.png',
                                height: 14,
                                width: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Image.asset(
                          'assets/images/music_waves.png',
                          height: 64,
                          width: Get.width,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: blackColor,
              ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
