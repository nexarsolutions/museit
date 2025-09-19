import 'package:get/get.dart';

import '../../../../../common_models/song_model.dart';

class ViewSavedPlaylistController extends GetxController{
  List <SongModel> songsList = [
    SongModel(
      imagePath: 'assets/images/thumbnail_1.png',
      songName: 'Lost Umbrella',
      length: '05:47 min',
    ),
    SongModel(
      imagePath: 'assets/images/thumbnail_2.png',
      songName: 'Clockwork Hearts',
      length: '05:47 min',
    ),
    SongModel(
      imagePath: 'assets/images/thumbnail_3.png',
      songName: 'The Lighthouse Whispered',
      length: '05:47 min',
    ),
    SongModel(
      imagePath: 'assets/images/thumbnail_4.png',
      songName: 'Recording 1',
      length: '05:47 min',
    ),
  ];
}