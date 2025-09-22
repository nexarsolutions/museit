import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/common_widgets/recipients_card.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/sender_side/sender_home/playlist_sent_bottom_sheet/playlist_sent_bottom_sheet.dart';
import 'package:musit/pages/sender_side/sender_home/sender_view_recipient/controller/sender_view_recipient_controller.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_button.dart';

import '../../../../widgets/custom_text_field.dart';

class SenderViewRecipientScreen extends StatelessWidget {
  SenderViewRecipientScreen({super.key});
  final controller = Get.put(SenderViewRecipientController());
  final RxBool isSelected = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Recipients', isBack: true,showLastIcon: true,lastWidget: Image.asset('assets/images/upload_icon_rounded.png',scale: 3.5,),),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Column(
                children: [
                  CustomTextField(
                    borderRadius: 50,
                    controller: TextEditingController(),
                    hintText: 'Search',
                    isSuffixIcon: true,
                    suffixIcon: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: blackColor,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/search_icon.png',
                        scale: 3,
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    padding: EdgeInsets.only(bottom: 30),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 13.0,
                          mainAxisSpacing: 10.0,
                          mainAxisExtent: 150,
                        ),
                    itemCount: controller.recipientsList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: RecipientsCard(
                          model: controller.recipientsList[index],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 42),
                  CustomButton(onPressed: () {
                    playlistSentBottomSheet();
                  }, text: 'Send'),

                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        return isSelected.value
                            ? GestureDetector(
                                onTap: () {
                                  isSelected.value = false;
                                },
                                child: Image.asset(
                                  'assets/images/tick_purple.png',
                                  width: 22,
                                  height: 22,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  isSelected.value = true;
                                },
                                child: Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(
                                          0xFF8C7FAC,
                                        ).withValues(alpha: 0.15),
                                        Color(
                                          0xFF7695CA,
                                        ).withValues(alpha: 0.15),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                ),
                              );
                      }),
                      SizedBox(width: 12),
                      Text(
                        'Allow to share in community',
                        style: manRope.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          decoration: TextDecoration.underline,
                          decorationColor: blackColor,
                        ),
                      ),
                    ],
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
