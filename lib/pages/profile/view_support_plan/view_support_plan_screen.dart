import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/profile/purchase_history/model/support_plan_model.dart';
import 'package:musit/widgets/custom_bottom_sheet.dart';

import '../../../constants/text_styles.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';

class ViewSupportPlanScreen extends StatelessWidget {
  const ViewSupportPlanScreen({super.key, required this.model});
  final SupportPlanModel model;
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
                  Center(
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(model.profilePicture),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Center(child: Text(model.name, style: manRopeSemiBold)),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        'Health Type',
                        style: manRopeSemiBold.copyWith(fontSize: 12),
                      ),
                      SizedBox(width: 16),
                      Text(
                        model.healthType,
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
                        model.disease,
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
                    model.story,
                    style: manRope.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                      color: lightBlack,
                    ),
                  ),
                  SizedBox(height: 12),

                  Row(
                    children: [
                      Text(
                        'Plan 1',
                        style: manRopeSemiBold.copyWith(fontSize: 12),
                      ),
                      SizedBox(width: 16),
                      Text(
                        model.price.toStringAsFixed(2),
                        style: manRope.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: lightBlack,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  Row(
                    children: [
                      Text(
                        'Date',
                        style: manRopeSemiBold.copyWith(fontSize: 12),
                      ),
                      SizedBox(width: 16),
                      Text(
                        model.date,
                        style: manRope.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: lightBlack,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: Get.height * 0.2),
                  Center(
                    child: CustomButton(
                      onPressed: () {
                        customBottomSheet(
                          padding: EdgeInsets.only(top: 42,bottom: 24,left: 36,right: 36),
                          child: Column(
                            children: [
                              Text(
                                'Proceeding with this action results in cancellation of donation plan.',
                                style: manRopeSemiBold.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 42),
                              Center(
                                child: CustomButton(
                                  onPressed: () {
                                  },
                                  text: 'Cancel Anyway',
                                ),
                              ),

                            ],
                          ),
                        );
                      },
                      text: 'Cancel Plan',
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
