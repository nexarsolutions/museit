import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart' as fs;
import 'package:get/get.dart';
import 'package:musit/pages/music_player/music_player_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common_widgets/song_card.dart';
import '../../../globalModels/song_model.dart';
import '../../../widgets/sender_empty_wave_form.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../utils/custom_error_snack_bar.dart';
import '../utils/dialog_utilities.dart';

class CustomVoiceRecordingScreen extends StatefulWidget {
  /// Called when all recordings need to be processed (e.g. next/continue)
  final Function(RxList<SongModel> list)? onNext;

  const CustomVoiceRecordingScreen({
    super.key,
    this.onNext,
  });

  @override
  State<CustomVoiceRecordingScreen> createState() =>
      _CustomVoiceRecordingScreenState();
}

class _CustomVoiceRecordingScreenState
    extends State<CustomVoiceRecordingScreen> {
  final fs.FlutterSoundRecorder recorder = fs.FlutterSoundRecorder();
  final RecorderController recorderController = RecorderController();
  final PlayerController audioPlayerController = PlayerController();

  RxBool isRecording = false.obs;
  RxBool isPlaying = false.obs;

  String? currentRecordingPath;
  Rx<PlayerState> playerState = PlayerState.stopped.obs;

  final recordingList = <SongModel>[].obs;

  @override
  void initState() {
    super.initState();
    recorder.openRecorder();

    // Listen to player state updates
    audioPlayerController.onPlayerStateChanged.listen((state) {
      playerState.value = state;
      isPlaying.value = (state == PlayerState.playing);
    });
  }

  // --- Start recording ---
  Future<void> startRecording() async {
    final micPermission = await Permission.microphone.request();
    if (!micPermission.isGranted) {
      Get.snackbar("Permission Denied",
          "Microphone access is required to record voice notes.");
      return;
    }

    final dir = await getTemporaryDirectory();
    currentRecordingPath =
        '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.aac';

    await recorderController.record(path: currentRecordingPath!);
    isRecording.value = true;
  }

  // --- Stop recording ---
  Future<void> stopRecording() async {
    final path = await recorderController.stop();
    isRecording.value = false;

    if (path != null) {
      currentRecordingPath = path;
      await audioPlayerController.preparePlayer(
        path: path,
        shouldExtractWaveform: true,
      );
    }
  }

  // --- Play or Pause current recording ---
  Future<void> togglePlayPause() async {
    if (currentRecordingPath == null) return;

    if (audioPlayerController.playerState == PlayerState.playing) {
      await audioPlayerController.pausePlayer();
      isPlaying.value = false;
    } else {
      await audioPlayerController.startPlayer();
      isPlaying.value = true;
    }
  }

  // --- Reset current recording session ---
  Future<void> refreshRecording() async {
    await audioPlayerController.stopPlayer();
    recorderController.reset();

    currentRecordingPath = null;
    isRecording.value = false;
    isPlaying.value = false;
  }

  // --- Save current recording and reset UI ---
  Future<void> saveRecording() async {
    if (currentRecordingPath == null ||
        !(File(currentRecordingPath!).existsSync())) {
      errorDialog(
          title: "No Recording", content: "Record something before saving.");
      return;
    }

    final fileName = "Recording ${recordingList.length + 1}";
    recordingList.clear(); //if multiple change later
    recordingList.add(
      SongModel(
        // image: 'assets/images/recording_thumbnail.png',
        name: fileName,
        link: currentRecordingPath,
      ),
    );

    await refreshRecording();

    customErrorSnackBar(content: "$fileName has been added to your list.");
  }

  @override
  void dispose() {
    audioPlayerController.dispose();
    recorderController.dispose();
    recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Obx(
          () => Column(
            children: [
              // --- Waveform display ---
              if (isRecording.value)
                AudioWaveforms(
                  size: Size(Get.width * 0.9, 100),
                  recorderController: recorderController,
                  waveStyle: const WaveStyle(
                    showDurationLabel: false,
                    spacing: 8.0,
                    waveColor: Color(0xFF8C7FAC),
                    middleLineColor: Color(0xFF7695CA),
                    showBottom: true,
                    extendWaveform: true,
                    showMiddleLine: false,
                  ),
                )
              else if (currentRecordingPath != null)
                AudioFileWaveforms(
                  size: Size(Get.width * 0.9, 100),
                  playerController: audioPlayerController,
                  enableSeekGesture: true,
                  playerWaveStyle: const PlayerWaveStyle(
                    spacing: 8.0,
                    fixedWaveColor: Color(0xFF8C7FAC),
                    liveWaveColor: Color(0xFF7695CA),
                    showSeekLine: true,
                    showBottom: true,
                    seekLineColor: Colors.white,
                  ),
                )
              else
                const SenderEmptyWaveForm(),

              const SizedBox(height: 10),

              // --- Control Buttons (Play / Record / Reset) ---
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    width: 180,
                    height: 34,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF8C7FAC).withOpacity(0.15),
                          const Color(0xFF7695CA).withOpacity(0.15),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (currentRecordingPath != null &&
                                !isRecording.value) {
                              togglePlayPause();
                            }
                          },
                          child: Icon(
                            isPlaying.value
                                ? Icons.pause_circle
                                : Icons.play_circle,
                            color: blackColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: refreshRecording,
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
                      if (isRecording.value) {
                        stopRecording();
                      } else {
                        startRecording();
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isRecording.value ? Colors.red : blackColor,
                      ),
                      child: Image.asset(
                        'assets/images/recording_icon.png',
                        scale: 4,
                        color: isRecording.value ? Colors.white : null,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // --- Save Button ---
        GestureDetector(
          onTap: () async {
            if (isRecording.value) {
              customErrorSnackBar(content: 'Stop recording');

              return;
            }
            await saveRecording();
          },
          child: Container(
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
        ),

        const SizedBox(height: 24),
        // --- Next Button ---
        GestureDetector(
          onTap: () => widget.onNext?.call(recordingList),
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
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    color: blueColor,
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
        // SizedBox(
        //   height: 16,
        // ),
        // Container(
        //   width: Get.width,
        //   height: 1,
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [
        //         const Color(0xFF8C7FAC).withOpacity(0.3),
        //         const Color(0xFF7695CA).withOpacity(0.3),
        //       ],
        //       begin: Alignment.centerLeft,
        //       end: Alignment.centerRight,
        //     ),
        //   ),
        // ),
        // --- List of Saved Recordings ---
        Obx(
          () => ListView.builder(
            padding: const EdgeInsets.only(bottom: 16, top: 16),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recordingList.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Get.to(() => MusicPlayerScreen(
                    songTitle: recordingList[index].name!,
                    songUrl: recordingList[index].link!,
                    imagePath: /*recordingList[index].image!*/ ''));
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SongCard(model: recordingList[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
