import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/common_models/my_compaigns_model.dart';
import 'package:musit/common_widgets/song_card.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';

import '../../../../widgets/custom_app_bar.dart';
import '../charity_donations/charity_donations_screen.dart';

class ViewMyCompaignsScreen extends StatelessWidget {
  const ViewMyCompaignsScreen({super.key, required this.model});
  final MyCompaignsModel model;
  @override
  Widget build(BuildContext context) {
    final double progressValue = model.currentPrice / model.GoalPrice;

    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: Get.height * 0.35,
                  child: Stack(
                    children: [
                      Image.asset(
                        model.imagePath,
                        height: Get.height * 0.35,
                        width: Get.width,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: Get.width,
                          height: Get.height * 0.1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(0.0),
                                Colors.white,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomAppBar(text: '', isBack: true),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: progressValue,
                    minHeight: 6,
                    backgroundColor: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    valueColor: const AlwaysStoppedAnimation<Color>(blackColor),
                  ),
                  SizedBox(height: 6),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>CharityDonationsScreen());
                    },
                    child: Center(
                      child: Text(
                        '\$${model.GoalPrice.toString()}/\$${model.currentPrice.toString()}',
                        style: manRopeSemiBold.copyWith(
                          fontSize: 10,
                          decoration: TextDecoration.underline,
                          decorationColor: blackColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Campaign Name',
                    style: manRopeSemiBold.copyWith(fontSize: 14),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        'Goal',
                        style: manRopeSemiBold.copyWith(fontSize: 14),
                      ),
                      SizedBox(width: 16),
                      Text(
                        '\$${model.GoalPrice.toString()}',
                        style: manRope.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),

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
                  SizedBox(height: 24),
                  Text('Cause', style: manRopeSemiBold.copyWith(fontSize: 14)),
                  SizedBox(height: 8),
                  Text(
                    model.cause,
                    style: manRope.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                    ),
                  ),

                  SizedBox(height: 12),
                  Text(
                    'Description',
                    style: manRopeSemiBold.copyWith(fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Text(
                    model.description,
                    style: manRope.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                    ),
                  ),

                  SizedBox(height: 16),
                  Text(
                    'Attached Playlist',
                    style: manRopeSemiBold.copyWith(fontSize: 14),
                  ),

                  SizedBox(height: 12),
                  ListView.builder(
                    padding: EdgeInsets.only(bottom: 24),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    itemCount: model.attachedPlaylist.length,
                    itemBuilder: (context, index) =>
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: SongCard(model: model.attachedPlaylist[index]),
                        ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
