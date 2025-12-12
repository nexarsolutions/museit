import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/app_enums.dart';
import '../../../../../globalModels/cart_model.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/web_view_screen.dart';
import '../../../../../widgets/youtube_player_widget.dart';
import '../../../../charity_side/charity_home/charity_add_songs/widget/add_songs_widget.dart';
import '../../../../music_player/music_player_screen.dart';
import '../../../../viewCharityOrg/view_charity_organization.dart';

class CartListBottomSheet extends StatelessWidget {
  final RxList<CartModel> cartItems;

  const CartListBottomSheet({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: Get.height * 0.6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
          ),
          cartItems.isEmpty
              ? SizedBox(
                  height: 300,
                  child: Center(child: Text("Cart is Empty")),
                )
              : Expanded(
                  child: Obx(() => ListView.builder(
                        itemCount: cartItems.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final cart = cartItems[index];

                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(height: 10),
                                    ...cart.songs.map((song) => GestureDetector(
                                          onTap: () {
                                            if (song.typeId == 1) {
                                              String trackId = song.link
                                                  .toString()
                                                  .split(':')
                                                  .last;
                                              String trackName =
                                                  song.name ?? '';

                                              Get.to(() => WebViewScreen(
                                                  title: trackName,
                                                  url: 'https://open'
                                                      '.spotify'
                                                      '.com/embed/track/$trackId'));
                                            } else if (song.typeId == 2) {
                                              String playUrl =
                                                  'https://www.youtube'
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    ...cart.voices.map((v) => GestureDetector(
                                        onTap: () {
                                          Get.to(() => MusicPlayerScreen(
                                              songTitle: v[AudioKey.name],
                                              songUrl: v[AudioKey.path],
                                              imagePath: /*recordingList[index].image!*/
                                                  ''));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            spacing: 10,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.asset(
                                                  'assets/images/app_icon.jpg',
                                                  width: 60,
                                                  height: 60,
                                                ),
                                              ),
                                              Text("${v[AudioKey.name]}"),
                                            ],
                                          ),
                                        ))),
                                  ],

                                  const SizedBox(height: 8),

                                  /// 👤 Recipients
                                  if (cart.defaultRecipientIds.isNotEmpty) ...[
                                    const Text("Recipients",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    ...cart.defaultRecipientIds.map((r) => Text(
                                        "• ${r.name ?? r.email ?? r.phone}")),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      )),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              cartItems.isEmpty
                  ? CustomButton(
                      onPressed: () {},
                      text: "Cart is Empty",
                      backgroundColor: Colors.grey,
                    )
                  : CustomButton(
                      onPressed: () {
                        Get.to(() => ViewCharityOrganization());
                      },
                      text: 'Checkout'),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
