import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/text_styles.dart';
import '../../../../../globalModels/song_model.dart';
import '../../../../../widgets/web_view_screen.dart';
import '../../../../charity_side/charity_home/charity_add_songs/widget/add_songs_widget.dart';
import '../controller/add_songs_controller.dart';

class BuildSpotifyWidget extends StatelessWidget {
  const BuildSpotifyWidget({super.key, required this.controller});

  final AddSongsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          // const SizedBox(height: 16),
          if (controller.isSpotifyLoading.value)
            const Center(child: CircularProgressIndicator())
          else if (controller.searchSpotifyResults.isEmpty)
            Center(
                child: Text(
              "Empty",
              style: manRope,
            ))
          else
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              primary: false,
              itemCount: controller.searchSpotifyResults.length,
              itemBuilder: (context, index) {
                final spotifySong = controller.searchSpotifyResults[index];

                final song = SongModel(
                  typeId: 1,
                  name: spotifySong['name'],
                  link: spotifySong['uri'],
                  // artist: spotifySong['artists'][0]['name'],
                  image: spotifySong['image'],
                );

                return Obx(
                  () {
                    bool isSelected = controller.songs.value.any(
                      (element) => element.link == song.link,
                    );

                    return GestureDetector(
                      onTap: () {
                        String trackId =
                            spotifySong['uri'].toString().split(':').last;
                        String trackName = spotifySong['name'];

                        Get.to(() => WebViewScreen(
                            title: trackName,
                            url: 'https://open'
                                '.spotify'
                                '.com/embed/track/$trackId'));
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
                            controller.songs.add(song..typeId = 1);
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
