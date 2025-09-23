import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

import '../../../../common_widgets/song_card.dart';
import '../../../charity_side/charity_home/charity_add_voice_note/charity_add_voice_note_screen.dart';
import '../paid_songs_recipient/paid_songs_recipient_screen.dart';
import 'controller/paid_songs_add_voice_note_controller.dart';

class PaidSongsAddVoiceNoteScreen extends StatelessWidget {
   PaidSongsAddVoiceNoteScreen({super.key, required this.imagePath, required this.title});
final controller = Get.put(PaidSongsAddVoiceNoteController());
final String imagePath;
final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Add Voice Note', isBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border(
                                left: BorderSide(color: purpleColor, width: 0.7),

                                right: BorderSide(color: purpleColor, width: 0.7),
                                bottom: BorderSide(color: purpleColor, width: 0.7),
                                // top ko intentionally blank rakha
                              ),
                            ),
                          ),
                        ),

                        // ✅ Content of card
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 6,
                            right: 20,
                            top: 6,
                            bottom: 6,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Profile image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  imagePath,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              const SizedBox(width: 12),

                              // Name + Plan (left side text)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: manRopeSemiBold.copyWith(fontSize: 12),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Motivational',
                                      style: manRope.copyWith(
                                        fontSize: 12,
                                        color: lightBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                               Column(
                                children: [
                                  SizedBox(height: 24),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      'Price 25p',
                                      style: manRopeSemiBold.copyWith(fontSize: 8),
                                    ),
                                  ),
                                ],
                              )
                                  ,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Obx(
                        () => Column(
                      children: [
                        // Waveform Display Area - now without a background container
                        if (controller.isRecording.value)
                          AudioWaveforms(
                            size: Size(Get.width * 0.9, 100),
                            recorderController: controller.recorderController,
                            waveStyle: WaveStyle(
                              showDurationLabel: false,
                              spacing: 8.0,
                              waveColor: Color(0xFF8C7FAC),
                              middleLineColor: Color(0xFF7695CA),
                              showBottom: true,
                              extendWaveform: true,
                              showMiddleLine: false,
                            ),
                          )
                        else if (controller.currentRecordingPath != null)
                          AudioFileWaveforms(
                            size: Size(Get.width * 0.9, 100),
                            playerController: controller.audioPlayerController,
                            enableSeekGesture: true,
                            playerWaveStyle: PlayerWaveStyle(
                              spacing: 8.0,
                              fixedWaveColor: Color(0xFF8C7FAC),
                              liveWaveColor: Color(0xFF7695CA),
                              showSeekLine: true,
                              showBottom: true,
                              seekLineColor: Colors.white,
                            ),
                          )
                        else
                          EmptyWaveform(),
                        SizedBox(height: 20),
                        // Control Buttons (Play, Mic, Refresh)
                        Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              width: 180,
                              height: 34,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF8C7FAC).withOpacity(0.15),
                                    Color(0xFF7695CA).withOpacity(0.15),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (controller.currentRecordingPath !=
                                          null &&
                                          !controller.isRecording.value) {
                                        controller.togglePlayPause();
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/images/play_icon.png',
                                      scale: 3.5,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.refreshRecording();
                                    },
                                    child: Image.asset(
                                      'assets/images/refresh_icon.png',
                                      scale: 3.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (controller.isRecording.value) {
                                  controller.stopRecording();
                                } else {
                                  controller.startRecording();
                                }
                              },
                              child: Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: blackColor,
                                ),
                                child: Image.asset(
                                  'assets/images/recording_icon.png',
                                  scale: 4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 110,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: blackColor,
                        ),
                        child: Center(
                          child: Text(
                            'Save',
                            style: manRopeSemiBold.copyWith(
                              fontSize: 12,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Container(
                        width: 110,
                        height: 32,
                        decoration: BoxDecoration(
                          border: Border.all(color: blackColor),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'Add More',
                            style: manRopeSemiBold.copyWith(
                              fontSize: 12,
                              color: blackColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Container(
                    width: Get.width,
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF8C7FAC).withOpacity(0.3),
                          Color(0xFF7695CA).withOpacity(0.3),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  ListView.builder(
                    padding: EdgeInsets.only(bottom: 24),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    itemCount: controller.recordingList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SongCard(model: controller.recordingList[index]),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.05),
                  GestureDetector(
                    onTap: () {
                      // Get.to(()=>SenderCreatedPlaylistScreen());
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

                        GestureDetector(
                          onTap: (){
                            Get.to(()=>PaidSongsRecipientScreen());
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
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );  }
}
