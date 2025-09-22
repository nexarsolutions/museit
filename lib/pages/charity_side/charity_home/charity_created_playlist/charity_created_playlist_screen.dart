import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/charity_side/charity_home/charity_home/charity_home_screen.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_button.dart';

import '../../../../common_widgets/song_card.dart';
import 'controller/charity_created_playlist_controller.dart';

class CharityCreatedPlaylistScreen extends StatelessWidget {
  CharityCreatedPlaylistScreen({super.key});
  final controller = Get.put(CharityCreatedPlaylistController());
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
                  CustomButton(onPressed: (){
                    Get.offAll(()=>CharityHomeScreen());
                  }, text: 'Save'),
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
