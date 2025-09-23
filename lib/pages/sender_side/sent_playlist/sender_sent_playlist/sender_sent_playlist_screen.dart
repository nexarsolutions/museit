import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../common_widgets/saved_playlist_card.dart';
import '../view_sent_playlist/view_sent_playlist_screen.dart';
import 'controller/sender_sent_playlist_controller.dart';

class SenderSentPlaylistScreen extends StatelessWidget {
  SenderSentPlaylistScreen({super.key});
  final controller = Get.put(SenderSentPlaylistController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Sent Playlist', isBack: true),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 30),
              itemCount: controller.playlistList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16,
                    bottom: 16,
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Get.to(()=>ViewSentPlaylistScreen(model: controller.playlistList[index],));
                    },
                    child: SavedPlaylistCard(
                      showDateTime: true,
                      model: controller.playlistList[index],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
