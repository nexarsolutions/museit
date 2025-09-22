import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

import '../../../../common_widgets/song_card.dart';
import '../charity_created_playlist/charity_created_playlist_screen.dart';
import 'controller/charity_add_voice_note_controller.dart';

// New widget to display a straight line for the waveform
class EmptyWaveform extends StatelessWidget {
  const EmptyWaveform({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      height: 100,
      // Removed the background decoration to make it transparent
      child: Center(
        child: CustomPaint(
          size: Size(Get.width * 0.7, 2),
          painter: _StraightLinePainter(),
        ),
      ),
    );
  }
}

class CharityAddVoiceNoteScreen extends StatelessWidget {
  CharityAddVoiceNoteScreen({super.key});
  final controller = Get.put(CharityAddVoiceNoteController());
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
                      Get.to(()=>CharityCreatedPlaylistScreen());
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
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for the straight line waveform
class _StraightLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [Color(0xFF8C7FAC), Color(0xFF7695CA)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = size.height
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
