import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/utils/extensions.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_button.dart';

import '../../../../globalModels/health_support_response_model.dart';
import '../support_plan/support_plan_screen.dart';

class HealthSupportDetailsScreen extends StatelessWidget {
  const HealthSupportDetailsScreen({super.key, required this.model});

  final HealthSupportModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Health Support', isBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(builder: (context) {
                    final image = model.user?.profile.value;
                    final name = model.user?.username.text;
                    return Column(
                      children: [
                        Center(
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: image != ''
                                  ? Image(
                                      image: CachedNetworkImageProvider(
                                        image.showImage,
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      color: greyColor,
                                      child: Center(
                                        child: Text(
                                          name != ''
                                              ? name
                                                      ?.trim()
                                                      .split('')
                                                      .first
                                                      .toUpperCase() ??
                                                  '?'
                                              : '?',
                                          style: manRopeSemiBold.copyWith(
                                            color: whiteColor,
                                            fontSize:
                                                50, // proportional to 145px size
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Center(
                            child: Text(name ?? 'Loading...',
                                style: manRopeSemiBold)),
                      ],
                    );
                  }),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        'Health Type',
                        style: manRopeSemiBold.copyWith(fontSize: 12),
                      ),
                      SizedBox(width: 16),
                      Text(
                        model.healthTypeName ?? "N/A",
                        style: manRope.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: lightBlack,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Text(
                        'Disease',
                        style: manRopeSemiBold.copyWith(fontSize: 12),
                      ),
                      SizedBox(width: 16),
                      Text(
                        model.disease ?? "N/A",
                        style: manRope.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: lightBlack,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Text(
                        'Monthly Aid Goal',
                        style: manRopeSemiBold.copyWith(fontSize: 12),
                      ),
                      SizedBox(width: 16),
                      Text(
                        '\$${model.monthlyAidGoal.toString()}',
                        style: manRope.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: lightBlack,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Story', style: manRopeSemiBold.copyWith(fontSize: 12)),
                  SizedBox(height: 8),
                  Text(
                    model.story ?? "N/A",
                    style: manRope.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                      color: lightBlack,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.2),
                  Center(
                    child: CustomButton(
                      onPressed: () {
                        Get.to(() => SupportPlanScreen());
                      },
                      text: 'Donate',
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
