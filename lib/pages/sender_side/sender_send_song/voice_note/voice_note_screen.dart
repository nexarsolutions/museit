import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/main.dart';
import 'package:musit/pages/sendBottombar/controller/sender_bottom_bar_controller.dart';
import 'package:musit/pages/sender_side/sender_send_song/add_songs/add_songs_screen.dart';
import 'package:musit/pages/sender_side/sender_send_song/voice_note/widget/image_carousel_slider.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../services/auth_service.dart';
import '../../../../widgets/custom_voice_recording_screen.dart';
import 'controller/voice_note_controller.dart';

class VoiceNoteScreen extends StatelessWidget {
  VoiceNoteScreen({
    super.key,
  });

  final controller = Get.put(VoiceNoteController());
  final RxBool switchValue = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.5,
            child: Stack(
              children: [
                ImageCarouselSlider(
                    ['assets/images/select_role_background.png']),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: CustomAppBar(
                      text: '',
                      isBack: true,
                      onTap: () {
                        Get.put(SenderBottomBarController()).selectedTab.value =
                            0;
                      },
                      textColor: whiteColor,
                      lastWidget: userManager.cachedUser?.currentRoleId == null
                          ? const SizedBox.shrink()
                          : userManager.cachedUser?.currentRoleId == 3
                              ? const SizedBox.shrink()
                              : Row(
                                  spacing: 4,
                                  children: [
                                    Text(
                                      userManager.cachedUser?.currentRoleId == 1
                                          ? 'Receiver '
                                          : 'Sender ',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: whiteColor),
                                    ),
                                    SizedBox(
                                      width: 40,
                                      child: Obx(() => Switch(
                                            value: switchValue.value,
                                            inactiveThumbColor: blackColor,
                                            inactiveTrackColor: blueColor,
                                            onChanged: (value) async {
                                              if (value = true) {
                                                bool roleAvailable = userManager
                                                        .cachedUser
                                                        ?.availableRoles
                                                        .contains(userManager
                                                                    .cachedUser!
                                                                    .currentRoleId ==
                                                                1
                                                            ? 2
                                                            : 1) ??
                                                    false;

                                                if (roleAvailable) {
                                                  await AuthService().switchRole(
                                                      roleId: userManager
                                                                  .cachedUser!
                                                                  .currentRoleId ==
                                                              1
                                                          ? 2
                                                          : 1);
                                                } else {
                                                  await AuthService().addRole(
                                                      roleId: userManager
                                                                  .cachedUser!
                                                                  .currentRoleId ==
                                                              1
                                                          ? 2
                                                          : 1);
                                                }
                                              }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                    )),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                    height: Get.height * 0.15,
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
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomVoiceRecordingScreen(
                onNext: (song) {
                  Get.to(() => AddSongsScreen(voiceSongs: song));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
