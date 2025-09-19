import 'package:get/get.dart';

import '../../../../../common_models/saved_playlist_model.dart';


class SavedPlaylistController extends GetxController {
  List<SavedPlaylistModel> playlistList = [
    SavedPlaylistModel(
      imagePath: 'assets/images/thumbnail_1.png',
      name: 'Midnight on Maple Street',
      category: 'Grief',
      author: 'Kathy James',
      authorProfile: 'assets/images/dummy_rounded_1.png',
      likes: 2.5,
    ),
    SavedPlaylistModel(
      imagePath: 'assets/images/thumbnail_2.png',
      name: 'Echoes in the Fog',
      category: 'Motivational',
      author: 'Kathy James',
      authorProfile: 'assets/images/dummy_rounded_1.png',
      likes: 2.5,
    ),
    SavedPlaylistModel(
      imagePath: 'assets/images/thumbnail_3.png',
      name: 'Lost Umbrella',
      category: 'Grief',
      author: 'Kathy James',
      authorProfile: 'assets/images/dummy_rounded_1.png',
      likes: 2.5,
    ),
    SavedPlaylistModel(
      imagePath: 'assets/images/thumbnail_4.png',
      name: 'Clockwork Hearts',
      category: 'Grief',
      author: 'Kathy James',
      authorProfile: 'assets/images/dummy_rounded_1.png',
      likes: 2.5,
    ),
    SavedPlaylistModel(
      imagePath: 'assets/images/thumbnail_5.png',
      name: 'The Lighthouse Whispered',
      category: 'Grief',
      author: 'Kathy James',
      authorProfile: 'assets/images/dummy_rounded_1.png',
      likes: 2.5,
    ),
  ];
}
