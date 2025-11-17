import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/pages/sender_side/sender_home/sender_home/sender_home_screen.dart';

import '../../sender_side/sender_send_song/voice_note/voice_note_screen.dart';
import '../../viewMyRecipients/view_my_recipients.dart';

class SenderBottomBarController extends GetxController {
  RxInt selectedTab = 0.obs;

  static List<Widget> widgets = [
    SenderHomeScreen(),
    VoiceNoteScreen(),
    ViewMyRecipients(
      showbutton: false,
    )
  ];
}
