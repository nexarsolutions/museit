import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/recipient_side/recieved_songs/recieved_songs/controller/recieved_songs_controller.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../common_widgets/song_card.dart';
import '../recieved_songs_musicplayer/recieved_songs_musicplayer_screen.dart';

class RecievedSongsScreen extends StatelessWidget {
   RecievedSongsScreen({super.key});
final controller = Get.put(RecievedSongsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Recieved Songs',isBack: true,),
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
                            () => RecievedSongsMusicPlayerScreen(
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
