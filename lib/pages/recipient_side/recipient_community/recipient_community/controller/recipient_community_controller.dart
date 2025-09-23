import 'package:get/get.dart';
import 'package:musit/common_models/saved_playlist_model.dart';


class RecipientCommunityController extends GetxController{
  var selectedTab = 0.obs;
  List<SavedPlaylistModel> motivationalList = [
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
  List<SavedPlaylistModel> griefList = [
    SavedPlaylistModel(
      imagePath: 'assets/images/thumbnail_2.png',
      name: 'Echoes in the Fog',
      category: 'Motivational',
      author: 'Kathy James',
      authorProfile: 'assets/images/dummy_rounded_1.png',
      likes: 2.5,
    ),
    SavedPlaylistModel(
      imagePath: 'assets/images/thumbnail_1.png',
      name: 'Midnight on Maple Street',
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
      imagePath: 'assets/images/thumbnail_3.png',
      name: 'Lost Umbrella',
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
  List<SavedPlaylistModel> encourageList = [
    SavedPlaylistModel(
      imagePath: 'assets/images/thumbnail_3.png',
      name: 'Lost Umbrella',
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
    SavedPlaylistModel(
      imagePath: 'assets/images/thumbnail_2.png',
      name: 'Echoes in the Fog',
      category: 'Motivational',
      author: 'Kathy James',
      authorProfile: 'assets/images/dummy_rounded_1.png',
      likes: 2.5,
    ),
    SavedPlaylistModel(
      imagePath: 'assets/images/thumbnail_1.png',
      name: 'Midnight on Maple Street',
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

  ];
  List<SavedPlaylistModel> loveList = [
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