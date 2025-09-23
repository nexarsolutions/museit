import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/common_models/my_compaigns_model.dart';
import 'package:musit/common_widgets/song_card.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/widgets/custom_button.dart';

import '../../../../widgets/custom_app_bar.dart';
import '../../../sender_side/subscriptions/payment_details/payment_details_screen.dart';
import '../../home/recipient_home/recipient_home_screen.dart';

class ViewRecipientCharityCompaignScreen extends StatelessWidget {
  const ViewRecipientCharityCompaignScreen({super.key, required this.model});
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
                CustomAppBar(
                  text: '',
                  isBack: true,
                  showLastIcon: true,
                  lastWidget: Image.asset(
                    'assets/images/copy_icon.png',
                    scale: 3.5,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 12,),
                            LinearProgressIndicator(
                              value: progressValue,
                              minHeight: 6,
                              backgroundColor: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                blackColor,
                              ),
                            ),
                            SizedBox(height: 6),
                            Center(
                              child: Text(
                                '\$${model.GoalPrice.toString()}/\$${model.currentPrice.toString()}',
                                style: manRopeSemiBold.copyWith(
                                  fontSize: 10,
                                  decoration: TextDecoration.underline,
                                  decorationColor: blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      CustomButton(
                        onPressed: () {
                          Get.to(
                                () => PaymentDetailsScreen(
                              isSender: false,
                              confirmOnTap: () {
                                Get.offAll(() => RecipientHomeScreen());
                              },
                            ),
                          );

                        },
                        text: 'Donate',
                        width: 150,
                        height: 40,
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Campaign Name',
                          style: manRopeSemiBold.copyWith(fontSize: 14),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/dummy_profile.png',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Kathy James',
                            style: manRopeSemiBold.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
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
                    itemBuilder: (context, index) => Padding(
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
