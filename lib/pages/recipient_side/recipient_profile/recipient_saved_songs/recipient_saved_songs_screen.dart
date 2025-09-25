import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../common_widgets/song_card.dart';
import '../../../music_player/music_player_screen.dart';
import 'controller/recipient_saved_songs_controller.dart';

class RecipientSavedSongsScreen extends StatelessWidget {
   RecipientSavedSongsScreen({super.key});
  final controller = Get.put(RecipientSavedSongsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Saved Songs',isBack: true,),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 30),
              itemCount: controller.songsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16,left: 16,right: 16),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                            () => MusicPlayerScreen(
                          imagePath:
                          controller.songsList[index].imagePath,
                        ),
                      );
                    },
                    child: SongCard(model: controller.songsList[index]),
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
