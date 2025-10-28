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
  RxList<SongModel> librarySelected = <SongModel>[].obs;
  RxList<SongModel> library = <SongModel>[
    SongModel(
      typeId: 4,
      name: "zamona-net-indila-love-story.mp3",
      link:
          "https://museit-s3bucket.s3.eu-west-2.amazonaws.com/1761649879080-zamona-net-indila-love-story.mp3",
    ),
    SongModel(
      typeId: 4,
      name: "Ajj_Kal_Full_Song_1.mp3",
      link:
          "https://museit-s3bucket.s3.eu-west-2.amazonaws.com/1761649918475-Ajj_Kal_Full_Song_1.mp3",
    ),
    SongModel(
      typeId: 4,
      name: "Jis_Tan_Nu_Lagdi_Aye_3.mp3",
      link:
          "https://museit-s3bucket.s3.eu-west-2.amazonaws.com/1761649946413-Jis_Tan_Nu_Lagdi_Aye_3.mp3",
    ),
    SongModel(
      typeId: 4,
      name: "Dhoor_Pendi_Kaka_128_Kbps.mp3",
      link:
          "https://museit-s3bucket.s3.eu-west-2.amazonaws.com/1761649972080-Dhoor_Pendi_Kaka_128_Kbps.mp3",
    ),
    SongModel(
      typeId: 4,
      name: "128-Baazigar_O_Baazigar_-_Baazigar_128_Kbps.mp3",
      link:
          "https://museit-s3bucket.s3.eu-west-2.amazonaws.com/1761650000462-128-Baazigar_O_Baazigar_-_Baazigar_128_Kbps.mp3",
    ),
    SongModel(
      typeId: 4,
      name: "bollywood_KK_1976_-_Kabhi_Kabhi_Mere_Dil.mp3",
      link:
          "https://museit-s3bucket.s3.eu-west-2.amazonaws.com/1761650025866-bollywood_KK_1976_-_Kabhi_Kabhi_Mere_Dil.mp3",
    ),
    SongModel(
      typeId: 4,
      name: "Nainowale_Ne_(Padmaavat)_320_Kbps.mp3",
      link:
          "https://museit-s3bucket.s3.eu-west-2.amazonaws.com/1761650066022-Nainowale_Ne_%28Padmaavat%29_320_Kbps.mp3",
    ),
  ].obs;

  Future<void> shareSong(List<SongModel> voiceRecordings,
      String? receiverPhoneNumber, List<int> selectedUsers) async {
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

      for (var s in librarySelected) {
        songs.add(s);
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
        if (receiverPhoneNumber != null && receiverPhoneNumber != '')
          'phoneNumber': receiverPhoneNumber,
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
