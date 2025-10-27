import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

import '../../../../common_widgets/song_card.dart';
import '../../../../widgets/custom_bottom_sheet.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_voice_recording_screen.dart';
import '../../sender_home/sender_home/sender_home_screen.dart';
import '../../sender_home/sender_view_recipient/sender_view_recipient_screen.dart';
import 'controller/voice_note_controller.dart';

class VoiceNoteScreen extends StatelessWidget {
  VoiceNoteScreen({super.key});

  final controller = Get.put(VoiceNoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Add Voice Note', isBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomVoiceRecordingScreen(
                onNext: (song) {
                  Get.to(() => SenderViewRecipientScreen(
                        onPressedSave: (List<int> selectedUser, String? phone) {
                          if (selectedUser.isEmpty && phone == null) {
                            customErrorSnackBar(
                                content:
                                    "Select Users or enter phone number to continue");
                            return;
                          }

                        },
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
