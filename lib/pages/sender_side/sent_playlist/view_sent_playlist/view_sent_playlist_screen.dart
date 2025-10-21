import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/common_widgets/song_card.dart';
import 'package:musit/pages/music_player/music_player_screen.dart';
import 'package:musit/pages/sender_side/sender_home/sender_view_recipient/sender_view_recipient_screen.dart';
import 'package:musit/utils/extensions.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common_models/saved_playlist_model.dart';
import '../playlist_recipient/playlist_recipient_screen.dart';
import 'controller/view_sent_playlist_controller.dart';

class ViewSentPlaylistScreen extends StatelessWidget {
  ViewSentPlaylistScreen({
    super.key,
    this.playListId,
    this.showRecipients = true,
  });

  final int? playListId;

  final controller = Get.put(ViewSentPlaylistController());
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
                    Get.to(() => PlaylistRecipientScreen());
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
      body: FutureBuilder(
          future: controller.getPlayListById(playListId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  CustomAppBar(
                    text: '',
                    isBack: true,
                  ),
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              );
            }

            if (snapshot.hasError) {
              return Column(
                children: [
                  CustomAppBar(
                    text: '',
                    isBack: true,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: manRope,
                      ),
                    ),
                  ),
                ],
              );
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return Column(
                children: [
                  CustomAppBar(
                    text: '',
                    isBack: true,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Something went wrong try again later",
                        style: manRope,
                      ),
                    ),
                  ),
                ],
              );
            }

            final model = snapshot.requireData!;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: Get.height * 0.35,
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: model.image.value.showImage,
                              height: Get.height * 0.35,
                              width: Get.width,
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height: Get.height * 0.35,
                                    width: Get.width,
                                    color: Colors.grey.shade300,
                                  ),
                                );
                              },
                              errorWidget: (context, error, stackTrace) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height: Get.height * 0.35,
                                    width: Get.width,
                                    color: Colors.grey.shade300,
                                  ),
                                );
                              },
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
                      CustomAppBar(
                        text: '',
                        isBack: true,
                      ),
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
                                model.title.text,
                                style: manRopeSemiBold.copyWith(fontSize: 14),
                              ),
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.grey.shade300,
                                  backgroundImage: model.user != null &&
                                          model.user!.profile != null
                                      ? CachedNetworkImageProvider(
                                          model.user!.profile.showImage)
                                      : null,
                                  child: model.user != null &&
                                          model.user!.profile != null
                                      ? null
                                      : Center(
                                          child: Text(model.user?.username
                                                  ?.split('')
                                                  .first
                                                  .toUpperCase() ??
                                              "?"),
                                        ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  model.user?.username ?? "Loading...",
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
                              model.purposeName ?? 'N/A',
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
                                  '${'1'.toString()}k',
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
                          itemCount: model.songs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: GestureDetector(
                                onTap: () {
                                  // Get.to(
                                  //   () => MusicPlayerScreen(
                                  //     imagePath:
                                  //         controller.songsList[index].imagePath,
                                  //   ),
                                  // );
                                },
                                child: SongCard(model: model.songs[index]),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
