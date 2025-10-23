import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../common_widgets/saved_playlist_card.dart';
import '../../../../services/paylist_service.dart';
import '../../../../widgets/error_widget_future_stream.dart';
import '../../../sender_side/sent_playlist/view_sent_playlist/view_sent_playlist_screen.dart';

class ReceivedPlaylistScreen extends StatelessWidget {
  const ReceivedPlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Received Playlist', isBack: true),
          SizedBox(height: 12),
          Expanded(
            child: FutureBuilder(
                future: PlaylistService().getReceivedPlaylist(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ErrorWidgetFutureStream();
                  }

                  if (snapshot.hasError) {
                    return ErrorWidgetFutureStream(
                      error: snapshot.error.toString(),
                    );
                  }

                  if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data!.isEmpty) {
                    return const ErrorWidgetFutureStream(
                      error: 'No Data Found',
                    );
                  }

                  final playLists = snapshot.requireData;
                  return ListView.builder(
                    padding: EdgeInsets.only(bottom: 30),
                    itemCount: playLists.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Get.to(
                          () => ViewSentPlaylistScreen(
                            playListId: playLists[index]?.playlistId,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16,
                          bottom: 12,
                        ),
                        child: SavedPlaylistCard(
                          showDateTime: true,
                          playlist: playLists[index].playlist!,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
