import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/sender_side/subscriptions/subscriptions/widget/subscription_widget.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import '../../sender_home/sender_home/sender_home_screen.dart';
import '../payment_details/payment_details_screen.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key, this.paymentConfirmOnTap, this.isBack = false});
final void Function()? paymentConfirmOnTap;
final bool isBack;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Subscriptions',isBack: isBack,),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SubscriptionWidget(

                    subscribeOnTap: () {
                      Get.to(()=>PaymentDetailsScreen(confirmOnTap: paymentConfirmOnTap??(){
                        Get.to(()=>SenderHomeScreen());

                      },));
                    },
                    isOption1True: true,
                    isOption2True: true,
                    isOption3True: false,
                    isOption4True: false,
                    isOption5True: false,
                    planName: 'Silver',
                    price: 25,
                  ),
                  SizedBox(height: 12,),
                  SubscriptionWidget(
                    subscribeOnTap: () {
                      Get.to(()=>PaymentDetailsScreen(confirmOnTap: paymentConfirmOnTap??(){
                        Get.to(()=>SenderHomeScreen());

                      },));

                    },
                    isOption1True: true,
                    isOption2True: true,
                    isOption3True: true,
                    isOption4True: true,
                    isOption5True: false,
                    planName: 'Gold',
                    price: 50,
                  ),
                  SizedBox(height: 12,),
                  SubscriptionWidget(
                    subscribeOnTap: () {
                      Get.to(()=>PaymentDetailsScreen(confirmOnTap: paymentConfirmOnTap??(){
                        Get.to(()=>SenderHomeScreen());
                      },));

                    },
                    isOption1True: true,
                    isOption2True: true,
                    isOption3True: true,
                    isOption4True: true,
                    isOption5True: true,
                    planName: 'Premium',
                    price: 100,
                  ),
                  SizedBox(height: 24,)

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
