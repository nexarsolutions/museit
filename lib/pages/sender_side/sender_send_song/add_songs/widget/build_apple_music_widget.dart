import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/pages/sender_side/sender_send_song/add_songs/controller/add_songs_controller.dart';

import '../../../../../constants/text_styles.dart';
import '../../../../../globalModels/song_model.dart';
import '../../../../charity_side/charity_home/charity_add_songs/widget/add_songs_widget.dart';
import '../../../../music_player/music_player_screen.dart';

class BuildAppleMusicWidget extends StatelessWidget {
  const BuildAppleMusicWidget({super.key, required this.controller});

  final AddSongsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          if (controller.isAppleMusicLoading.value)
            const Center(child: CircularProgressIndicator())
          else if (controller.searchAppleMusicList.isEmpty)
            Center(
                child: Text(
              "Empty",
              style: manRope,
            ))
          else
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.zero,
              itemCount: controller.searchAppleMusicList.length,
              itemBuilder: (context, index) {
                final appleMusicSong = controller.searchAppleMusicList[index];

                final song = SongModel(
                  typeId: 3,
                  name: appleMusicSong["name"],
                  image: appleMusicSong["image"],
                  link: appleMusicSong["link"],
                );

                return Obx(
                  () {
                    bool isSelected = controller.songs.value.any(
                      (element) => element.link == song.link,
                    );

                    return GestureDetector(
                      onTap: () {
                        Get.to(() => MusicPlayerScreen(
                              songTitle: song.name ?? 'N/A',
                              songUrl: song.link ?? '',
                              imagePath: song.image ?? '',
                            ));
                      },
                      child: AddSongsWidget(
                        song: song,
                        isSelected: isSelected.obs,
                        showSelected: true,
                        onTap: () {
                          bool? isAlreadySelected = controller.songs.any(
                            (element) => element.link == song.link,
                          );
                          if (isAlreadySelected) {
                            controller.songs.removeWhere(
                                (element) => element.link == song.link);
                          } else {
                            controller.songs.clear();
                            controller.songs.add(song..typeId = 3);
                          }
                        },
                      ),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}


