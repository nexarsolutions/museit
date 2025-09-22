import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/charity_side/my_playlist/view_my_playlist/controller/view_my_playlist_controller.dart';
import 'package:musit/common_widgets/song_card.dart';
import 'package:musit/pages/music_player/music_player_screen.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../common_models/saved_playlist_model.dart';
import '../charity_see_recipient/charity_see_recipient_screen.dart';

class ViewMyPlaylistScreen extends StatelessWidget {
  ViewMyPlaylistScreen({
    super.key,
    required this.model,
    this.showRecipients = true,
  });
  final SavedPlaylistModel model;
  final controller = Get.put(ViewMyPlaylistController());
  final bool showRecipients;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: showRecipients == true
          ? SizedBox(
              height: 50,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => CharitySeeRecipientScreen());
                  },
                  child: Text(
                    'See Recipients',
                    style: manRope.copyWith(
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                      decorationColor: lightBlack,
                    ),
                  ),
                ),
              ),
            )
          : SizedBox.shrink(),

      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: Get.height * 0.35,
                  child: Stack(
                    children: [
                      Image.asset(
                        model.imagePath,
                        height: Get.height * 0.35,
                        width: Get.width,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: Get.width,
                          height: Get.height * 0.1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(0.0),
                                Colors.white,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomAppBar(text: '', isBack: true),
              ],
            ),
            SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          model.name,
                          style: manRopeSemiBold.copyWith(fontSize: 14),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(model.authorProfile),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            model.author,
                            style: manRopeSemiBold.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  Row(
                    children: [
                      Text(
                        'Playlist Purpose',
                        style: manRopeSemiBold.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 14),
                      Text(
                        model.category,
                        style: manRope.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Community Engagement',
                        style: manRopeSemiBold.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 14),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.suit_heart_fill,
                            color: blackColor,
                            size: 16,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '${model.likes.toString()}k',
                            style: manRope.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  Container(
                    width: Get.width,
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF8C7FAC).withValues(alpha: 0.3),
                          Color(0xFF7695CA).withValues(alpha: 0.3),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Playlist',
                    style: manRopeSemiBold.copyWith(fontSize: 12),
                  ),
                  SizedBox(height: 12),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 30),
                    itemCount: controller.songsList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              () => MusicPlayerScreen(
                                imagePath:
                                    controller.songsList[index].imagePath,
                              ),
                            );
                          },
                          child: SongCard(model: controller.songsList[index]),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
