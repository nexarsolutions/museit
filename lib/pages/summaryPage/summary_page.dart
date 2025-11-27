import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/main.dart';
import 'package:musit/pages/sender_side/sender_send_song/add_songs/controller/add_songs_controller.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_button.dart';

import '../../constants/app_enums.dart';
import '../../widgets/web_view_screen.dart';
import '../../widgets/youtube_player_widget.dart';
import '../charity_side/charity_home/charity_add_songs/widget/add_songs_widget.dart';
import '../music_player/music_player_screen.dart';

class SentSongSummaryPage extends StatelessWidget {
  SentSongSummaryPage({super.key});

  final controller = Get.put(AddSongsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        top: false,
        child: Column(
          spacing: 10,
          children: [
            CustomAppBar(
              text: "Summary",
              isBack: true,
            ),
            // ==== Image Section ====
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/images/song_summary.jpg",
                  height: Get.height * 0.35,
                  width: Get.width,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),

            Text(
              'Thank you for sending a MUSEiT Moment to ',
              style: manRopeSemiBold,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                itemCount: userManager.cartItems.length,
                itemBuilder: (context, index) {
                  final cart = userManager.cartItems[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Item ${index + 1}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// 🎵 Songs
                      if (cart.songs.isNotEmpty) ...[
                        const Text("Songs",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(height: 10),
                        ...cart.songs.map((song) => GestureDetector(
                              onTap: () {
                                if (song.typeId == 1) {
                                  String trackId =
                                      song.link.toString().split(':').last;
                                  String trackName = song.name ?? '';

                                  Get.to(() => WebViewScreen(
                                      title: trackName,
                                      url: 'https://open'
                                          '.spotify'
                                          '.com/embed/track/$trackId'));
                                } else if (song.typeId == 2) {
                                  String playUrl = 'https://www.youtube'
                                      '.com/watch?v=${song.link ?? ''}';

                                  Get.to(() => YouTubeAudioPlayer(
                                        videoUrl: playUrl,
                                      ));
                                } else if (song.typeId == 4) {
                                  Get.to(() => MusicPlayerScreen(
                                      songTitle: song.name ?? 'N/A',
                                      songUrl: song.link ?? '',
                                      imagePath:
                                          /* song.image ??*/
                                          ''));
                                }
                              },
                              child: AddSongsWidget(
                                song: song,
                                isSelected: false.obs,
                                showSelected: false,
                              ),
                            )),
                      ],

                      const SizedBox(height: 8),

                      /// 🎙 Voice Notes
                      if (cart.voices.isNotEmpty) ...[
                        const Text("Voice Notes",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        ...cart.voices
                            .map((v) => Text("• ${v[AudioKey.name]}")),
                      ],

                      const SizedBox(height: 8),

                      /// 👤 Recipients
                      if (cart.defaultRecipientIds.isNotEmpty) ...[
                        const Text("Recipients",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        ...cart.defaultRecipientIds.map(
                            (r) => Text("• ${r.name ?? r.email ?? r.phone}")),
                      ],
                    ],
                  );
                },
              ),
            ),

            SizedBox(height: 6),
            CustomButton(
                onPressed: () {
                  controller.shareSong();
                },
                text: 'Next'),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
