import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/viewCharityOrg/view_charity_organization.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

import '../../../../common_widgets/song_card.dart';
import '../../../../widgets/custom_bottom_sheet.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_voice_recording_screen.dart';
import '../../sender_home/sender_home/sender_home_screen.dart';
import '../../sender_home/sender_view_recipient/sender_view_recipient_screen.dart';
import '../../sender_home/sender_view_recipient/widget/send_via_phone_sheet.dart';
import '../add_songs/controller/add_songs_controller.dart';
import 'controller/voice_note_controller.dart';

class VoiceNoteScreen extends StatelessWidget {
  VoiceNoteScreen({super.key});

  final controller = Get.put(VoiceNoteController());
  final songController = Get.put(AddSongsController());

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
                  Get.to(() => ViewCharityOrganization(
                        onPressedSave: () {
                          Get.to(() => SenderViewRecipientScreen(
                                rowWidget: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // Show bottom sheet before sharing
                                        showSendViaPhoneSheet(
                                          context: Get.context!,
                                          onPhoneSubmitted: (phone) {
                                            songController
                                                .shareMomentExternally(
                                                    songController.songs, 'SMS',
                                                    receiver: phone);
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.sms, color: Colors.blue),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showSendViaPhoneSheet(
                                          context: Get.context!,
                                          onPhoneSubmitted: (phone) {
                                            songController
                                                .shareMomentExternally(
                                                    songController.songs,
                                                    'WhatsApp',
                                                    receiver: phone);
                                          },
                                        );
                                      },
                                      icon: Image.asset(

                                              "assets/images/whatsapp.png",
                                          width: 24,height: 24,
                                          // color: Colors.green
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showSendViaPhoneSheet(
                                          context: Get.context!,
                                          isEmail: true,
                                          onPhoneSubmitted: (phone) {
                                            songController
                                                .shareMomentExternally(
                                                    songController.songs,
                                                    'Email',
                                                    receiver: phone);
                                          },
                                        );
                                      },
                                      icon:
                                          Icon(Icons.email, color: Colors.red),
                                    ),
                                  ],
                                ),
                                onPressedSave:
                                    (List<int> selectedUser, String? phone) {
                                  if (selectedUser.isEmpty && phone == null) {
                                    customErrorSnackBar(
                                        content:
                                            "Select Users or enter phone number to continue");
                                    return;
                                  }
                                  songController.shareSong(
                                      song, phone, selectedUser);
                                },
                              ));
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
