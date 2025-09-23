import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/sender_side/send_playlist/sender_send_playlist/controller/sender_send_playlist_controller.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_tab_button.dart';

import '../../../music_player/music_player_screen.dart';
import '../../profile/purchase_history/widget/paid_songs_widget.dart';
import '../paid_songs_add_voice_note/paid_songs_add_voice_note_screen.dart';

class SenderSendPlaylistScreen extends StatelessWidget {
   SenderSendPlaylistScreen({super.key});
final controller = Get.put(SenderSendPlaylistController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Send Paid Songs',isBack: true,),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Obx(
                        () => CustomTabButton(
                      tabNames: const [
                        'Motivational',
                        'Grief',
                        'Encourage',
                        'Love',
                      ],
                      selectedIndex: controller.selectedTab.value,
                      onTabSelected: (index) {
                        controller.selectedTab.value = index;
                      },
                    ),
                  ),
                  SizedBox(height: 16,),
                  Obx(
    ()=> GridView.builder(

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
      itemCount: controller.selectedTab.value == 0
          ? controller.motivationalList.length
          : controller.selectedTab.value == 1
          ? controller.griefList.length
          : controller.selectedTab.value == 2
          ? controller.encourageList.length
          : controller.loveList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {

                            Get.to(()=>PaidSongsAddVoiceNoteScreen(
                              imagePath: controller.selectedTab.value == 0
                                  ? controller.motivationalList[index].imagePath
                                  : controller.selectedTab.value == 1
                                  ? controller.griefList[index].imagePath
                                  : controller.selectedTab.value == 2
                                  ? controller.encourageList[index].imagePath
                                  : controller.loveList[index].imagePath,

                              title: controller.selectedTab.value == 0
                                ? controller.motivationalList[index].songTitle
                                : controller.selectedTab.value == 1
                                ? controller.griefList[index].songTitle
                                : controller.selectedTab.value == 2
                                ? controller.encourageList[index].songTitle
                                : controller.loveList[index].songTitle,));
                          },
                          child: PaidSongsWidget(
                            model: controller.selectedTab.value == 0
                                ? controller.motivationalList[index]
                                : controller.selectedTab.value == 1
                                ? controller.griefList[index]
                                : controller.selectedTab.value == 2
                                ? controller.encourageList[index]
                                : controller.loveList[index],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
