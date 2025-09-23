import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../common_widgets/saved_playlist_card.dart';
import '../recieved_playlist/view_recieved_playlist/view_recieved_playlist_screen.dart';
import 'controller/recipient_saved_playlist_controller.dart';

class RecipientSavedPlaylistScreen extends StatelessWidget {
  RecipientSavedPlaylistScreen({super.key});
  final controller = Get.put(RecipientSavedPlaylistController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Recieved Playlist', isBack: true),
          SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 30),
              itemCount: controller.recentCardList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16,
                  bottom: 12,
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                          () => ViewRecievedPlaylistScreen(
                        showRecipients: false,
                        model: controller.recentCardList[index],
                      ),
                    );
                  },

                  child: SavedPlaylistCard(
                    showDateTime: true,
                    model: controller.recentCardList[index],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
