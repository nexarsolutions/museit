import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_tab_button.dart';

import '../../../../common_widgets/saved_playlist_card.dart';
import '../../../sender_side/profile/purchase_history/widget/renew_subscription_widget.dart';
import '../../recieved_playlist/view_recieved_playlist/view_recieved_playlist_screen.dart';
import 'controller/recipient_history_controller.dart';

class RecipientHistoryScreen extends StatelessWidget {
  RecipientHistoryScreen({super.key});
  final controller = Get.put(RecipientHistoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'History', isBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Obx(
                    () => CustomTabButton(
                      tabNames: const ['Subscription', 'Donations'],
                      selectedIndex: controller.selectedTab.value,
                      onTabSelected: (index) {
                        controller.selectedTab.value = index;
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                  Obx(
                    () => controller.selectedTab.value == 0
                        ? RenewSubscriptionWidget(
                            renewOnTap: () {},
                            isOption1True: true,
                            isOption2True: true,
                            isOption3True: false,
                            isOption4True: false,
                            isOption5True: false,
                            planName: 'Silver',
                            price: 25,
                          )
                        : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      primary: false,
                      padding: EdgeInsets.only(bottom: 30),
                      itemCount: controller.recentCardList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(
                          bottom: 12,
                        ),
                        child: GestureDetector(
                          onTap: () {
                          },

                          child: SavedPlaylistCard(
                            showDateTime: true,
                            model: controller.recentCardList[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
