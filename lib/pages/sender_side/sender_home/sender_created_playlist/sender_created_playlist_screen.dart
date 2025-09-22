import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/charity_side/charity_home/charity_home/charity_home_screen.dart';
import 'package:musit/pages/sender_side/sender_home/sender_created_playlist/controller/sender_created_playlist_controller.dart';
import 'package:musit/pages/sender_side/sender_home/sender_view_recipient/sender_view_recipient_screen.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_button.dart';

import '../../../../common_widgets/song_card.dart';
class SenderCreatedPlaylistScreen extends StatelessWidget {
  SenderCreatedPlaylistScreen({super.key});
  final controller = Get.put(SenderCreatedPlaylistController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Created Playlist', isBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.only(bottom: 30),
                    itemCount: controller.songsList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 16,
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: SongCard(
                            showPlaylistIcon: true,
                            model: controller.songsList[index],
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {

                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 1,
                              right: 1,
                              bottom: -3,
                              child: Container(
                                height: 30,
                                width: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusGeometry.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                  color: purpleColor,
                                ),
                              ),
                            ),

                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: redColor,
                              ),
                              child: Image.asset(
                                'assets/images/delete_icon.png',
                                scale: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8,),
                      GestureDetector(
                        onTap: () {
                          Get.to(()=>SenderViewRecipientScreen());
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 1,
                              right: 1,
                              bottom: -3,
                              child: Container(
                                height: 30,
                                width: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusGeometry.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                  color: purpleColor,
                                ),
                              ),
                            ),

                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: blackColor,
                              ),
                              child: Image.asset(
                                'assets/images/double_forwareded_icon.png',
                                scale: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
