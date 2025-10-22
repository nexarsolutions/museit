import 'dart:io';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/charity_side/charity_home/charity_add_songs/widget/add_songs_widget.dart';
import 'package:musit/pages/charity_side/charity_home/charity_add_voice_note/charity_add_voice_note_screen.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_button.dart';
import 'package:musit/widgets/custom_text_field.dart';
import '../../../../constants/text_styles.dart';
import '../../../../globalModels/song_model.dart';
import '../../../../services/paylist_service.dart';
import '../../../../utils/global_functions.dart';
import '../../../../utils/image_picker_bottom_sheet.dart';
import '../../../../widgets/audio_picker_widget.dart';
import '../../../../widgets/custom_tab_button.dart';
import '../voice_note/voice_note_screen.dart';
import 'controller/add_songs_controller.dart';

class AddSongsScreen extends StatelessWidget {
  AddSongsScreen({super.key});

  final controller = Get.put(AddSongsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Select Songs', isBack: true),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextField(
              borderRadius: 50,
              controller: controller.searchController,
              hintText: 'Search',
              isSuffixIcon: true,
              suffixIcon: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: blackColor,
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/images/search_icon.png', scale: 3),
              ),
              onChanged: (value) {
                if (value.trim().isEmpty) {
                  controller.searchQuery.value = '';
                } else {
                  controller.searchQuery.value = value.trim();
                }
              },
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Obx(
              () => CustomTabButtonWithIcon(
                selectedIndex: controller.songTypeId.value,
                // GetX ya setState use kar sakte ho
                onTabSelected: (index) {
                  controller.songTypeId.value = index;
                },
                tabs: [
                  TabItem(
                    title: "Spotify",
                    selectedIcon: 'assets/images/spotify_selected.png',
                    unselectedIcon: 'assets/images/spotify.png',
                  ),
                  TabItem(
                    title: "Youtube",
                    selectedIcon: 'assets/images/youtube_selected.png',
                    unselectedIcon: 'assets/images/youtube.png',
                  ),
                  TabItem(
                    title: "Paid Songs",
                    selectedIcon: 'assets/images/paid_icon_selected.png',
                    unselectedIcon: 'assets/images/paid_icon.png',
                  ),
                  TabItem(
                    title: "Upload",
                    selectedIcon: 'assets/images/upload_selected.png',
                    unselectedIcon: 'assets/images/upload.png',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Obx(
            () => controller.songTypeId.value == 0
                ? Expanded(
                    child: Center(
                      child: Text("No Songs Found"),
                    ),
                  )
                : controller.songTypeId.value == 1
                    ? Expanded(
                        child: Center(
                          child: Text("No Songs Found"),
                        ),
                      )
                    : controller.songTypeId.value == 2
                        ? Expanded(
                            child: Obx(
                              () => FutureBuilder(
                                  key: ValueKey(controller.searchQuery.value),
                                  future: PlaylistService().getSongs(
                                      search: controller.searchQuery.value),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                    if (snapshot.hasError) {
                                      return Center(
                                          child: Text(snapshot.error.toString(),
                                              style: manRopeSemiBold));
                                    }

                                    if (!snapshot.hasData ||
                                        snapshot.data == null ||
                                        snapshot.data!.isEmpty) {
                                      return Center(
                                          child: Text("No Songs Found",
                                              style: manRopeSemiBold));
                                    }

                                    final songsList = snapshot.requireData;

                                    return ListView.builder(
                                      itemCount: songsList.length,
                                      itemBuilder: (context, index) {
                                        return Obx(
                                          () {
                                            bool? isSelected =
                                                controller.songs.any(
                                              (element) =>
                                                  element.id ==
                                                  songsList[index].id,
                                            );

                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16.0,
                                                right: 16,
                                                bottom: 12,
                                              ),
                                              child: AddSongsWidget(
                                                  song: songsList[index],
                                                  isSelected: isSelected.obs,
                                                  onTap: () {
                                                    bool? isAlreadySelected =
                                                        controller.songs.any(
                                                      (element) =>
                                                          element.id ==
                                                          songsList[index].id,
                                                    );
                                                    if (isAlreadySelected) {
                                                      controller.songs
                                                          .removeWhere(
                                                              (element) =>
                                                                  element.id ==
                                                                  songsList[
                                                                          index]
                                                                      .id);
                                                    } else {
                                                      controller.songs.add(
                                                          songsList[index]
                                                            ..typeId = 3);
                                                    }
                                                  }),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  }),
                            ),
                          )
                        : Expanded(
                            child: Column(
                              children: [
                                AudioPickerWidget(
                                  onUploadComplete: (uploadedFileNames) {
                                    for (var name in uploadedFileNames) {
                                      final song = SongModel(
                                        typeId: 4,
                                        name: name.split('.').first, // optional
                                        link: name,
                                      );
                                      controller.songs.add(song);
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Expanded(
                                    child: Obx(
                                  () => ListView.builder(
                                    itemCount: controller.songs.length,
                                    itemBuilder: (context, index) {
                                      final song = controller.songs[index];

                                      return song.typeId != 4
                                          ? const SizedBox.shrink()
                                          : AddSongsWidget(
                                              song: song,
                                              isSelected: false.obs,
                                              showSelected: false,
                                            );
                                    },
                                  ),
                                )),
                              ],
                            ),
                          ),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                  onPressed: () {
                    Get.to(() => VoiceNoteScreen());
                  },
                  text: 'Save'),
              // SizedBox(width: 8),
              // Stack(
              //   clipBehavior: Clip.none,
              //   children: [
              //     Positioned(
              //       left: 1,
              //       right: 1,
              //       bottom: -3,
              //       child: Container(
              //         height: 30,
              //         width: 48,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadiusGeometry.only(
              //             bottomLeft: Radius.circular(16),
              //             bottomRight: Radius.circular(16),
              //           ),
              //           color: blueColor,
              //         ),
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         Get.to(() => VoiceNoteScreen());
              //       },
              //       child: Container(
              //         width: 50,
              //         height: 50,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(16),
              //           color: blackColor,
              //         ),
              //         child: Image.asset(
              //           'assets/images/double_forwareded_icon.png',
              //           scale: 3,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
