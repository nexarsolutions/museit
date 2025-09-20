import 'package:get/get.dart';
import 'package:musit/pages/charity_side/charity_home/add_songs/model/add_songs_model.dart';

class AddSongsController extends GetxController {

final RxInt selectedIndex = 0.obs;
List <AddSongsModel> spotifyList = [
  AddSongsModel(imagePath: 'assets/images/thumbnail_1.png', title: 'Midnight on Maple Street', duration: '05:47 min'),
  AddSongsModel(imagePath: 'assets/images/thumbnail_2.png', title: 'Echoes in the Fog', duration: '05:47 min'),
  AddSongsModel(imagePath: 'assets/images/thumbnail_3.png', title: 'Lost Umbrella', duration: '05:47 min'),
  AddSongsModel(imagePath: 'assets/images/thumbnail_4.png', title: 'Clockwork Hearts', duration: '05:47 min'),
  AddSongsModel(imagePath: 'assets/images/thumbnail_5.png', title: 'The Lighthouse Whispered', duration: '05:47 min'),
];
List <AddSongsModel> youtubeList = [
  AddSongsModel(imagePath: 'assets/images/thumbnail_5.png', title: 'The Lighthouse Whispered', duration: '05:47 min'),
  AddSongsModel(imagePath: 'assets/images/thumbnail_4.png', title: 'Clockwork Hearts', duration: '05:47 min'),
  AddSongsModel(imagePath: 'assets/images/thumbnail_3.png', title: 'Lost Umbrella', duration: '05:47 min'),
  AddSongsModel(imagePath: 'assets/images/thumbnail_2.png', title: 'Echoes in the Fog', duration: '05:47 min'),
  AddSongsModel(imagePath: 'assets/images/thumbnail_1.png', title: 'Midnight on Maple Street', duration: '05:47 min'),
];
var pickedImagePath = ''.obs;

}