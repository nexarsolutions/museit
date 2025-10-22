import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../widgets/custom_voice_recording_screen.dart';
import '../sender_create_playlist/controller/sender_create_playlist_controller.dart';

class SenderAddVoiceNoteScreen extends StatelessWidget {
  SenderAddVoiceNoteScreen({super.key});

  final controller = Get.put(SenderCreatePlaylistController());

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
                  controller.createPlaylist(song);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
