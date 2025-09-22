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
import '../../../../utils/global_functions.dart';
import '../../../../utils/image_picker_bottom_sheet.dart';
import '../../../../widgets/custom_tab_button.dart';
import 'controller/charity_add_songs_controller.dart';

class CharityAddSongsScreen extends StatelessWidget {
  CharityAddSongsScreen({super.key});
  final controller = Get.put(CharityAddSongsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Add Songs', isBack: true),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextField(
              borderRadius: 50,
              controller: TextEditingController(),
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
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Obx(
              () => CustomTabButtonWithIcon(
                selectedIndex: controller
                    .selectedIndex
                    .value, // GetX ya setState use kar sakte ho
                onTabSelected: (index) {
                  controller.selectedIndex.value = index;
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
            () => controller.selectedIndex.value == 0
                ? Expanded(
                    child: ListView.builder(
                      itemCount: controller.spotifyList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16,
                          bottom: 12,
                        ),
                        child: AddSongsWidget(
                          model: controller.spotifyList[index],
                        ),
                      ),
                    ),
                  )
                : controller.selectedIndex.value == 1
                ? Expanded(
                    child: ListView.builder(
                      itemCount: controller.youtubeList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16,
                          bottom: 12,
                        ),
                        child: AddSongsWidget(
                          model: controller.youtubeList[index],
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Container(
                            width: Get.width,
                            height: 130,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF8C7FAC).withValues(alpha: 0.15),
                                  Color(0xFF7695CA).withValues(alpha: 0.15),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),

                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(4),
                              decoration: DottedDecoration(
                                color: purpleColor,
                                strokeWidth: 1.2,
                                shape: Shape.box,
                                dash: const [3, 5],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Obx(
                                () => controller.pickedImagePath.value.isEmpty
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              pickImageBottomSheetFromCameraGallery(
                                                () async {
                                                  String? pickedImagePath =
                                                      await pickImage(
                                                        ImageSource.camera,
                                                      );
                                                  controller
                                                          .pickedImagePath
                                                          .value =
                                                      pickedImagePath!;
                                                  Get.back();
                                                },
                                                () async {
                                                  String? pickedImagePath =
                                                      await pickImage(
                                                        ImageSource.gallery,
                                                      );
                                                  controller
                                                          .pickedImagePath
                                                          .value =
                                                      pickedImagePath!;
                                                  Get.back();
                                                },
                                              );
                                            },
                                            child: Image.asset(
                                              'assets/images/upload_icon.png',
                                              height: 30,
                                              width: 30,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const SizedBox(height: 13),
                                          Text(
                                            'Upload',
                                            style: manRopeSemiBold.copyWith(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900,
                                              color: blackColor,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Center(
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          alignment: Alignment.topRight,
                                          children: [
                                            Image.file(
                                              File(
                                                controller
                                                    .pickedImagePath
                                                    .value,
                                              ),
                                            ),
                                            Positioned(
                                              top: -5,
                                              right: -5,
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller
                                                          .pickedImagePath
                                                          .value =
                                                      '';
                                                },
                                                child: const Icon(
                                                  size: 20,
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(onPressed: () {
                Get.to(()=>CharityAddVoiceNoteScreen());

              }, text: 'Save'),
              SizedBox(width: 8),
              Stack(
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

                  GestureDetector(
                    onTap: (){
                      Get.to(()=>CharityAddVoiceNoteScreen());
                    },
                    child: Container(
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
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
