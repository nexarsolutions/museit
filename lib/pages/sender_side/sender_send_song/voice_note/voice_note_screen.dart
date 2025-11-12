import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/main.dart';
import 'package:musit/pages/sendBottombar/controller/sender_bottom_bar_controller.dart';
import 'package:musit/pages/sender_side/sender_send_song/add_songs/add_songs_screen.dart';
import 'package:musit/pages/sender_side/sender_send_song/voice_note/widget/image_carousel_slider.dart';
import 'package:musit/pages/viewCharityOrg/view_charity_organization.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../widgets/custom_voice_recording_screen.dart';
import '../../sender_home/sender_view_recipient/sender_view_recipient_screen.dart';
import '../../sender_home/sender_view_recipient/widget/send_via_phone_sheet.dart';
import '../add_songs/controller/add_songs_controller.dart';
import 'controller/voice_note_controller.dart';

class VoiceNoteScreen extends StatelessWidget {
  VoiceNoteScreen({
    super.key,
  });

  final controller = Get.put(VoiceNoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.35,
            child: Stack(
              children: [
                ImageCarouselSlider(
                    ['assets/images/select_role_background.png']),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: CustomAppBar(
                        text: 'Add Voice Note',
                        isBack: false,
                        textColor: whiteColor)),
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
