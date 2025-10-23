import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../common_widgets/song_card.dart';
import '../../../../services/paylist_service.dart';
import '../../../../widgets/error_widget_future_stream.dart';
import '../recieved_songs_musicplayer/recieved_songs_musicplayer_screen.dart';

class ReceivedSongsScreen extends StatelessWidget {
  const ReceivedSongsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            text: 'Recieved Songs',
            isBack: true,
          ),
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

                  final songsList = snapshot.requireData;

                  return ListView.builder(
                    padding: EdgeInsets.only(bottom: 30),
                    itemCount: songsList.length,
                    itemBuilder: (context, index) {
                      final song = songsList[index].paidSongs!;

                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16, left: 16, right: 16),
                        child: GestureDetector(
                          onTap: () {
                            // Get.to(
                            //   () => RecievedSongsMusicPlayerScreen(
                            //     imagePath:
                            //         controller.songsList[index].imagePath,
                            //   ),
                            // );
                          },
                          child: SongCard(model: song),
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
