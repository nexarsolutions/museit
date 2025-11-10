import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/main.dart';
import 'package:musit/pages/sendBottombar/controller/sender_bottom_bar_controller.dart';
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
  VoiceNoteScreen({super.key});

  final controller = Get.put(VoiceNoteController());
  final songController = Get.put(AddSongsController());

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
                ImageCarouselSlider(['assets/images/select_role_background.png']),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: CustomAppBar(text: 'Add Voice Note', isBack: true,textColor: whiteColor)),
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
                  Get.to(() => ViewCharityOrganization(
                        onPressedSave: () {
                          Get.to(() => SenderViewRecipientScreen(
                                rowWidget: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // IconButton(
                                    //   onPressed: () {
                                    //     // Show bottom sheet before sharing
                                    //     showSendViaPhoneSheet(
                                    //       context: Get.context!,
                                    //       onPhoneSubmitted: (phone) {
                                    //         songController
                                    //             .shareMomentExternally(
                                    //                 songController.songs, 'SMS',
                                    //                 receiver: phone);
                                    //       },
                                    //     );
                                    //   },
                                    //   icon: Icon(Icons.sms, color: Colors.blue),
                                    // ),
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
                                        width: 35, height: 35,
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
                                          Icon(Icons.email, color: Colors.red,size: 40,),
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
                                  songController.shareSong(song, phone, selectedUser);
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
