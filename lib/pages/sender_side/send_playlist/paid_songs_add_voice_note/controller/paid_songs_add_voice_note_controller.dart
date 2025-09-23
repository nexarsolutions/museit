import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter_sound/flutter_sound.dart' as fs;

import '../../../../../common_models/song_model.dart';

class PaidSongsAddVoiceNoteController extends GetxController{
  final fs.FlutterSoundRecorder recorder = fs.FlutterSoundRecorder();
  final RecorderController recorderController = RecorderController();
  final PlayerController audioPlayerController = PlayerController();

  RxBool isRecording = false.obs;
  String? currentRecordingPath;
  Rx<PlayerState> playerState = PlayerState.stopped.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize both controllers.
    recorder.openRecorder();
    audioPlayerController.onPlayerStateChanged.listen((state) {
      playerState.value = state;
    });
  }

  Future<void> startRecording() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      final dir = await getTemporaryDirectory();
      currentRecordingPath = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.aac';

      // The codec parameter is not needed here.
      await recorderController.record(
        path: currentRecordingPath!,
      );
      isRecording.value = true;
    } else {
      Get.snackbar("Permission Denied", "Microphone access is required to record voice notes.");
    }
  }
  Future<void> stopRecording() async {
    // Stop the waveform recorder controller.
    final path = await recorderController.stop();
    isRecording.value = false;
    if (path != null) {
      currentRecordingPath = path;
      // Prepare the player controller with the recorded file.
      audioPlayerController.preparePlayer(path: path, shouldExtractWaveform: true);
    }
  }

  Future<void> togglePlayPause() async {
    if (currentRecordingPath == null) return;
    if (audioPlayerController.playerState == PlayerState.playing) {
      audioPlayerController.pausePlayer();
    } else {
      audioPlayerController.startPlayer();
    }
  }

  void refreshRecording() {
    currentRecordingPath = null;
    isRecording.value = false;
    audioPlayerController.stopPlayer();
    recorderController.reset();
  }

  List<SongModel> recordingList = [
    SongModel(
      imagePath: 'assets/images/recording_thumbnail.png',
      songName: 'Recording 1',
      length: '05:47 min',
    ),
    SongModel(
      imagePath: 'assets/images/recording_thumbnail.png',
      songName: 'Recording 2',
      length: '05:47 min',
    ),
  ];

  @override
  void onClose() {
    audioPlayerController.dispose();
    recorderController.dispose();
    recorder.closeRecorder();
    super.onClose();
  }
}