import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../globalModels/song_model.dart';
import '../../../../charity_side/charity_home/charity_add_songs/model/add_songs_model.dart';

class AddSongsController extends GetxController {
  final RxInt songTypeId = 0.obs;

  final searchController = TextEditingController();
  RxString searchQuery = ''.obs;

  RxList<SongModel> songs=<SongModel>[].obs;
}
