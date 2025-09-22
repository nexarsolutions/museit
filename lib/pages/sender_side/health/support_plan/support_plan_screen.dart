import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/sender_side/health/support_plan/widget/support_plan_widget.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_bottom_sheet.dart';
import '../../../../constants/text_styles.dart';
import '../../../../widgets/custom_button.dart';
import '../../sender_home/sender_home/sender_home_screen.dart';
import '../../subscriptions/payment_details/payment_details_screen.dart';

class SupportPlanScreen extends StatelessWidget {
  const SupportPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Support Plan', isBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SupportPlanWidget(
                    subscribeOnTap: () {
                      Get.to(
                        () => PaymentDetailsScreen(
                          confirmOnTap: () {
                            customBottomSheet(
                              padding: EdgeInsets.only(
                                top: 42,
                                left: 33,
                                right: 33,
                                bottom: 24,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Thank you for supporting people suffered with long term mental or physical illness.',
                                    style: manRopeSemiBold.copyWith(
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 50),
                                  CustomButton(
                                    onPressed: () {
                                      Get.offAll(() => SenderHomeScreen());
                                    },
                                    text: 'Okay',
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                    planName: 'Plan 1',
                    price: 10.00,
                    subtotal: 10.00,
                    serviceFee: 10.00,
                  ),
                  SizedBox(height: 12),
                  SupportPlanWidget(
                    subscribeOnTap: () {
                      Get.to(
                        () => PaymentDetailsScreen(
                          confirmOnTap: () {
                            customBottomSheet(
                              padding: EdgeInsets.only(
                                top: 42,
                                left: 33,
                                right: 33,
                                bottom: 24,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Thank you for supporting people suffered with long term mental or physical illness.',
                                    style: manRopeSemiBold.copyWith(
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 50),
                                  CustomButton(
                                    onPressed: () {
                                      Get.offAll(() => SenderHomeScreen());
                                    },
                                    text: 'Okay',
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                    planName: 'Plan 2',
                    price: 20.00,
                    subtotal: 10.00,
                    serviceFee: 10.00,
                  ),
                  SizedBox(height: 12),
                  SupportPlanWidget(
                    subscribeOnTap: () {
                      Get.to(
                        () => PaymentDetailsScreen(
                          confirmOnTap: () {
                            customBottomSheet(
                              padding: EdgeInsets.only(
                                top: 42,
                                left: 33,
                                right: 33,
                                bottom: 24,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Thank you for supporting people suffered with long term mental or physical illness.',
                                    style: manRopeSemiBold.copyWith(
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 50),
                                  CustomButton(
                                    onPressed: () {
                                      Get.offAll(() => SenderHomeScreen());
                                    },
                                    text: 'Okay',
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                    planName: 'Plan 3',
                    price: 30.00,
                    subtotal: 10.00,
                    serviceFee: 10.00,
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
