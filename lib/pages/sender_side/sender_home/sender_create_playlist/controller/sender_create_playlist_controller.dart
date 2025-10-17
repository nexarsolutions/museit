import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musit/constants/global_list.dart';
import 'package:musit/globalModels/playlist_model.dart';
import 'package:musit/utils/dialog_utilities.dart';

class SenderCreatePlaylistController extends GetxController {
  final PlaylistModel playlistModel = PlaylistModel();

  RxnString selectedPurpose =RxnString();

  Future<void> createPlaylist() async {
    try {
      loadingDialog(message: "Creating");
      playlistModel.purposeId = getPurposeIndex();
      Get.back();
    } catch (e) {
      Get.back();
      errorDialog(content: e.toString());
    }
  }

  int getPurposeIndex() {
    return playlistPurposes.indexOf(selectedPurpose.value!);
  }
}
