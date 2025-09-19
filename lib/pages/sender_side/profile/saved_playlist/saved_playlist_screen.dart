import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../common_widgets/saved_playlist_card.dart';
import '../view_saved_playlist/view_saved_playlist_screen.dart';
import 'controller/saved_playlist_controller.dart' show SavedPlaylistController;

class SavedPlaylistScreen extends StatelessWidget {
  SavedPlaylistScreen({super.key});
  final controller = Get.put(SavedPlaylistController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Saved Playlist', isBack: true),
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
                      Get.to(()=>ViewSavedPlaylistScreen(model: controller.playlistList[index],));
                    },
                    child: SavedPlaylistCard(
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
