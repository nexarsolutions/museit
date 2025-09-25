import 'package:get/get.dart';

import '../../../../../common_models/saved_playlist_model.dart';

class RecipientHistoryController extends GetxController {
  final RxInt selectedTab = 0.obs;

  List<SavedPlaylistModel> recentCardList = [
    SavedPlaylistModel(
      imagePath: 'assets/images/compaign_1.png',
      name: 'Campaign Name',
      category: 'Donation \$50',
      authorProfile: 'assets/images/dummy_rounded_3.png',
      author: 'author',
      likes: 2.5,
    ),
    SavedPlaylistModel(
      imagePath: 'assets/images/compaign_2.png',
      name: 'Campaign Name',
      category: 'Donation \$50',
      authorProfile: 'assets/images/dummy_rounded_3.png',
      author: 'author',
      likes: 2.5,
    ),
    SavedPlaylistModel(
      imagePath: 'assets/images/compaign_3.png',
      name: 'Campaign Name',
      category: 'Donation \$50',
      authorProfile: 'assets/images/dummy_rounded_3.png',
      author: 'author',
      likes: 2.5,
    ),
    SavedPlaylistModel(
      imagePath: 'assets/images/compaign_4.png',
      name: 'Campaign Name',
      category: 'Donation \$50',
      authorProfile: 'assets/images/dummy_rounded_3.png',
      author: 'author',
      likes: 2.5,
    ),
    SavedPlaylistModel(
      imagePath: 'assets/images/compaign_5.png',
      name: 'Campaign Name',
      category: 'Donation \$50',
      authorProfile: 'assets/images/dummy_rounded_3.png',
      author: 'author',
      likes: 2.5,
    ),
  ];
}
