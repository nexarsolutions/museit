import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/pages/sender_side/sender_home/sender_home/sender_home_screen.dart';

import '../../sender_side/sender_home/sender_view_recipient/sender_view_recipient_screen.dart';
import '../../sender_side/sender_send_song/voice_note/voice_note_screen.dart';

class SenderBottomBarController extends GetxController {
  RxInt selectedTab = 0.obs;

  static List<Widget> widgets = [
    SenderHomeScreen(),
    VoiceNoteScreen(),
    SenderViewRecipientScreen(
      onPressedSave: (song, p) {},
      showbutton: false,
    )
  ];
}
