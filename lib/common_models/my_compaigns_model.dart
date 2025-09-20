import 'package:musit/common_models/song_model.dart';

class MyCompaignsModel {
  final String imagePath;
  final String compaignName;
  final int GoalPrice;
  final String cause;
  final String description;
  final double currentPrice; // New property

  final List<SongModel> attachedPlaylist;

  MyCompaignsModel({
    required this.imagePath,
    required this.compaignName,
    required this.GoalPrice,
    required this.cause,
    required this.description,
    required this.currentPrice,
    required this.attachedPlaylist,
  });
}
