import 'package:get/get.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/utils/dialog_utilities.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter_sound/flutter_sound.dart' as fs;
import 'dart:io';

import '../../../../../globalModels/song_model.dart';

class SenderAddVoiceNoteController extends GetxController {
  final fs.FlutterSoundRecorder recorder = fs.FlutterSoundRecorder();
  final RecorderController recorderController = RecorderController();
  final PlayerController audioPlayerController = PlayerController();

  RxBool isRecording = false.obs;
  RxBool isPlaying = false.obs;

  String? currentRecordingPath;
  Rx<PlayerState> playerState = PlayerState.stopped.obs;

  final recordingList = <SongModel>[].obs;

  @override
  void onInit() {
    super.onInit();
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
    recordingList.add(
      SongModel(
        image: 'assets/images/recording_thumbnail.png',
        name: fileName,
        link: currentRecordingPath,
      ),
    );

    await refreshRecording();

    customErrorSnackBar(content: "$fileName has been added to your list.");
  }

  @override
  void onClose() {
    audioPlayerController.dispose();
    recorderController.dispose();
    recorder.closeRecorder();
    super.onClose();
  }
}
