// ui/received_songs_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/music_player/music_player_screen.dart';
import '../../../common_widgets/song_card.dart';
import '../../../constants/colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/web_view_screen.dart';
import 'controller/received_songs_controller.dart';

class ReceivedSongsScreen extends StatelessWidget {
  const ReceivedSongsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReceivedSongsController());
    final scrollController = ScrollController();

    // 👇 Add scroll listener for pagination
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !controller.isPaginating.value &&
          controller.hasMore) {
        controller.fetchReceivedSongs();
      }
    });

    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            text: 'Received Songs',
            isBack: true,
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value &&
                  controller.receivedSongs.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.isNotEmpty &&
                  controller.receivedSongs.isEmpty) {
                return Center(
                  child: Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (controller.receivedSongs.isEmpty) {
                return const Center(child: Text("No songs received yet."));
              }

              return RefreshIndicator(
                onRefresh: controller.refreshList,
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(12),
                  itemCount: controller.receivedSongs.length +
                      (controller.isPaginating.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= controller.receivedSongs.length) {
                      return const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final item = controller.receivedSongs[index];
                    final fromUser = item.fromUser;

                    // ✅ Filter songs by type
                    final filteredSongs = (item.items ?? [])
                        .where((song) => song.type?.toLowerCase() == 'song')
                        .toList();

                    // Skip card entirely if no valid "songs"
                    if (filteredSongs.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...filteredSongs.map((song) => GestureDetector(
                              onTap: () async {
                                if (song.typeId == 1) {
                                  String trackId =
                                      song.link.toString().split(':').last;
                                  String trackName = song.name ?? 'N/A';

                                  Get.to(() => WebViewScreen(
                                      title: trackName,
                                      url: 'https://open'
                                          '.spotify'
                                          '.com/track/$trackId'));
                                } else if (song.typeId == 4) {
                                  Get.to(() => MusicPlayerScreen(
                                      songTitle: song.name ?? '',
                                      songUrl: song.link ?? '',
                                      imagePath: ''));
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                child: SongCard(
                                  model: song,
                                  lastWidget: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
                                        backgroundImage:
                                            fromUser?.profile != null &&
                                                    fromUser?.profile != ''
                                                ? NetworkImage(
                                                    fromUser?.profile ?? '')
                                                : null,
                                        child: fromUser?.profile != null &&
                                                fromUser?.profile != ''
                                            ? null
                                            : Center(
                                                child: Text(
                                                fromUser?.username
                                                        ?.split('')
                                                        .first
                                                        .toUpperCase() ??
                                                    '?',
                                                style: manRopeSemiBold.copyWith(
                                                    fontSize: 22),
                                              )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ],
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
