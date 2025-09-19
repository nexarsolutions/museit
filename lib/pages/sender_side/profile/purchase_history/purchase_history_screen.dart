import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/sender_side/profile/purchase_history/widget/paid_songs_widget.dart';
import 'package:musit/pages/sender_side/profile/purchase_history/widget/renew_subscription_widget.dart';
import 'package:musit/pages/sender_side/profile/purchase_history/widget/support_plan_card.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../widgets/custom_tab_button.dart';
import '../view_support_plan/view_support_plan_screen.dart';
import 'controller/purchase_history_controller.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  PurchaseHistoryScreen({super.key});
  final controller = Get.put(PurchaseHistoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Purchase History', isBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Obx(
                    () => CustomTabButton(
                      tabNames: const [
                        'Subscription',
                        'Support Plan',
                        'Paid Songs',
                      ],
                      selectedIndex: controller.selectedTab.value,
                      onTabSelected: (index) {
                        controller.selectedTab.value = index;
                      },
                    ),
                  ),
                  Obx(
                    () => controller.selectedTab.value == 0
                        ? Column(
                            children: [
                              SizedBox(height: 42),
                              RenewSubscriptionWidget(
                                renewOnTap: () {},
                                isOption1True: true,
                                isOption2True: true,
                                isOption3True: false,
                                isOption4True: false,
                                isOption5True: false,
                                planName: 'Silver',
                                price: 25,
                              ),
                            ],
                          )
                        : controller.selectedTab.value == 1
                        ? Column(
                            children: [
                              SizedBox(height: 12),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                primary: false,
                                shrinkWrap: true,
                                itemCount: controller.supportPlanList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10.0,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          () => ViewSupportPlanScreen(
                                            model: controller
                                                .supportPlanList[index],
                                          ),
                                        );
                                      },
                                      child: SupportPlanCard(
                                        model:
                                            controller.supportPlanList[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        : Column(
                          children: [
                            SizedBox(height: 16,),
                            GridView.builder(

                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,

                                padding: EdgeInsets.only(bottom: 30),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 13.0,
                                      mainAxisSpacing: 10.0,
                                      mainAxisExtent: 145,
                                    ),
                                itemCount: controller.paidSongsList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: PaidSongsWidget(
                                      model: controller.paidSongsList[index],
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
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
