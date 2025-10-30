import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/pages/sender_side/sender_home/sender_home/sender_home_screen.dart';
import 'package:musit/pages/sender_side/sender_send_song/add_songs/add_songs_screen.dart';

class SenderBottomBarController extends GetxController {
  RxInt selectedTab = 0.obs;

  static List<Widget> widgets = [
    SenderHomeScreen(),
    AddSongsScreen(),
    // const SizedBox.shrink(),
    const SizedBox.shrink(),
  ];
}
