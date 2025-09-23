import 'package:get/get.dart';

import '../../../profile/purchase_history/model/paid_songs_model.dart';

class SenderSendPlaylistController extends GetxController{
  var selectedTab = 0.obs;
  List <PaidSongsModel> motivationalList = [
    PaidSongsModel(imagePath: 'assets/images/thumbnail_1.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_2.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_3.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_4.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_5.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_6.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_1.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_2.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_3.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_4.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_5.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_6.png', songTitle: 'Built to Rise', songPrice: 25),
  ];
  List <PaidSongsModel> griefList = [
    PaidSongsModel(imagePath: 'assets/images/thumbnail_3.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_4.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_5.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_2.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_3.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_4.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_5.png', songTitle: 'Lost Umbrella', songPrice: 25),

    PaidSongsModel(imagePath: 'assets/images/thumbnail_1.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_2.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_6.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_1.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_6.png', songTitle: 'Built to Rise', songPrice: 25),
  ];
  List <PaidSongsModel> encourageList = [
    PaidSongsModel(imagePath: 'assets/images/thumbnail_1.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_2.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_4.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_5.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_5.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_3.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_2.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_3.png', songTitle: 'Lost Umbrella', songPrice: 25),

    PaidSongsModel(imagePath: 'assets/images/thumbnail_6.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_1.png', songTitle: 'Lost Umbrella', songPrice: 25),

    PaidSongsModel(imagePath: 'assets/images/thumbnail_4.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_6.png', songTitle: 'Built to Rise', songPrice: 25),
  ];
  List <PaidSongsModel> loveList = [
    PaidSongsModel(imagePath: 'assets/images/thumbnail_4.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_5.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_2.png', songTitle: 'Built to Rise', songPrice: 25),

    PaidSongsModel(imagePath: 'assets/images/thumbnail_6.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_1.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_3.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_5.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_3.png', songTitle: 'Lost Umbrella', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_2.png', songTitle: 'Built to Rise', songPrice: 25),

    PaidSongsModel(imagePath: 'assets/images/thumbnail_1.png', songTitle: 'Lost Umbrella', songPrice: 25),

    PaidSongsModel(imagePath: 'assets/images/thumbnail_4.png', songTitle: 'Built to Rise', songPrice: 25),
    PaidSongsModel(imagePath: 'assets/images/thumbnail_6.png', songTitle: 'Built to Rise', songPrice: 25),
  ];


}