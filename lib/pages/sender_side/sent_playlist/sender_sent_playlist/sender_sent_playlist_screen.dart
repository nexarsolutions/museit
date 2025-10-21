import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../common_widgets/saved_playlist_card.dart';
import '../../../../constants/text_styles.dart';
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
            child: FutureBuilder(
                future: controller.getSendPlaylist(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Something went wrong',
                        style: manRope,
                      ),
                    );
                  }

                  if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'No data found',
                        style: manRope,
                      ),
                    );
                  }

                  final playlists = snapshot.requireData;

                  return ListView.builder(
                    padding: EdgeInsets.only(bottom: 30),
                    itemCount: playlists.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16,
                          bottom: 16,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => ViewSentPlaylistScreen(
                                  playListId: playlists[index].id,
                                ));
                          },
                          child: SavedPlaylistCard(
                            showDateTime: true,
                            playlist: playlists[index].playlist!,
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
