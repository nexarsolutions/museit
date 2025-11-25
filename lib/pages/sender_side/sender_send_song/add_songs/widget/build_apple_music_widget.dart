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
                        // Extract library song ID and catalog song ID
                        String librarySongId = appleMusicSong["id"]?.toString() ?? '';
                        String catalogSongId = appleMusicSong["catalogId"]?.toString() ?? '';
                        
                        // If catalog ID is not in the map, try to extract from link
                        if (catalogSongId.isEmpty && song.link != null) {
                          if (song.link!.contains('|catalog:')) {
                            final parts = song.link!.split('|catalog:');
                            catalogSongId = parts.length > 1 ? parts[1] : '';
                          }
                        }
                        
                        // Extract library song ID from link if needed
                        if (librarySongId.isEmpty && song.link != null) {
                          final linkPart = song.link!.contains('|') 
                              ? song.link!.split('|')[0] 
                              : song.link!;
                          final parts = linkPart.split('/');
                          if (parts.isNotEmpty) {
                            librarySongId = parts.last;
                          }
                        }
                        
                        // Prefer catalog song ID if available, otherwise use library song ID
                        final songIdToPlay = catalogSongId.isNotEmpty ? catalogSongId : librarySongId;
                        
                        if (songIdToPlay.isNotEmpty) {
                          Get.to(() => MusicPlayerScreen(
                                songTitle: song.name ?? 'N/A',
                                songUrl: song.link ?? '',
                                imagePath: song.image ?? '',
                                typeId: 3, // Apple Music
                                appleMusicSongId: librarySongId, // Pass library song ID, service will handle catalog lookup
                              ));
                        }
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



