import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/pages/sender_side/sender_send_song/add_songs/controller/add_songs_controller.dart';

import '../../../../../constants/text_styles.dart';
import '../../../../../globalModels/song_model.dart';
import '../../../../../widgets/youtube_player_widget.dart';
import '../../../../charity_side/charity_home/charity_add_songs/widget/add_songs_widget.dart';

class BuildYoutubeWidget extends StatelessWidget {
  const BuildYoutubeWidget({super.key, required this.controller});

  final AddSongsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          // const SizedBox(height: 16),
          if (controller.isYoutubeLoading.value)
            const Center(child: CircularProgressIndicator())
          else if (controller.searchInYoutubeList.isEmpty)
            // const Center(child: CircularProgressIndicator())
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
              itemCount: controller.searchInYoutubeList.length,
              itemBuilder: (context, index) {
                final youtubeSong = controller.searchInYoutubeList[index];

                final song = SongModel(
                  typeId: 2,
                  name: youtubeSong["title"],
                  image: youtubeSong["thumbnail"],
                  link: youtubeSong["videoId"],
                );

                return Obx(
                  () {
                    bool isSelected = controller.songs.value.any(
                      (element) => element.link == song.link,
                    );

                    return GestureDetector(
                      onTap: () {
                        String playUrl = 'https://www.youtube'
                            '.com/watch?v=${youtubeSong["videoId"] ?? ''}';

                        Get.to(() => YouTubeAudioPlayer(
                              videoUrl: playUrl,
                            ));
                        // Get.to(() => WebViewScreen(
                        //     title: youtubeSong.name ?? '', url: playUrl));
                        // Get.to(() => MusicPlayerScreen(
                        //     songTitle: song.name ?? 'N/A',
                        //     songUrl: song.link ?? '',
                        //     imagePath:
                        //         /* song.image ??*/
                        //         ''));
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
                            controller.songs.add(song..typeId = 2);
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
