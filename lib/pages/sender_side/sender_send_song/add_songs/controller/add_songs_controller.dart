import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/pages/sender_side/sender_home/sender_home/sender_home_screen.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/services/song_service.dart';
import 'package:musit/services/upload_file_service.dart';
import 'package:musit/utils/custom_error_snack_bar.dart';
import 'package:musit/utils/dialog_utilities.dart';
import 'package:musit/utils/global_functions.dart';

import '../../../../../constants/app_enums.dart';
import '../../../../../globalModels/song_model.dart';

class AddSongsController extends GetxController {
  final RxInt songTypeId = 0.obs;

  final searchController = TextEditingController();
  RxString searchQuery = ''.obs;

  RxList<SongModel> songs = <SongModel>[].obs;
  RxList<int> selectedUsers = <int>[].obs;
  RxnString receiverPhoneNumber = RxnString();

  Future<void> shareSong(List<SongModel> voiceRecordings) async {
    try {
      loadingDialog();
      List<Map<AudioKey, dynamic>> voices = [];
      if (voiceRecordings.isNotEmpty) {
        for (var voice in voiceRecordings) {
          final voicePath = await UploadFileService()
              .fileUploadResult(uploadData: voice.link ?? '');

          if (voicePath != null) {
            voices.add(
                {AudioKey.path: voicePath, AudioKey.name: voice.name ?? ''});
          } else {
            Get.back();
            return;
          }
        }
      }

      var data = {
        'songs': songs
            .map(
              (song) => song.toJson(),
            )
            .toList(),
        if (voices.isNotEmpty)
          'voiceNotes': voices
              .map((e) => {'name': e[AudioKey.name], 'link': e[AudioKey.path]})
              .toList(),
        if (selectedUsers.isNotEmpty)
          'toUserIds': selectedUsers
              .map(
                (user) => user,
              )
              .toList(),
        if (receiverPhoneNumber.value != null)
          'phoneNumber': receiverPhoneNumber.value,
      };
      Get.back(); //close loading dialog
      await ApiService().handleResponse(
        apiMethod: () => SongService().shareSongs(data),
        onSuccess: (Map<String, dynamic> response) {
          customPrint("add_songs_controller line 64: $response");
          Get.offAll(() => SenderHomeScreen());
          customErrorSnackBar(content: response['message']);
        },
      );
    } catch (e) {
      Get.back(); //close loading dialog
      errorDialog(content: e.toString());
    }
  }
}
