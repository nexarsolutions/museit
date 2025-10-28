// lib/models/charity_campaign_model.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CharityCampaignModel {
  final TextEditingController compaignTitle;
  final TextEditingController monthlyAidGoal;
  final TextEditingController cause;
  // final TextEditingController goalAmount;
  // final TextEditingController bankName;
  // final TextEditingController accountNumber;
  // final TextEditingController accountTitle;

  // final RxString playlist;
  final RxString imageUrl;

  CharityCampaignModel({
    required this.compaignTitle,
    required this.monthlyAidGoal,
    required this.cause,
    // required this.goalAmount,
    // required this.bankName,
    // required this.accountNumber,
    // required this.accountTitle,
    // required this.playlist,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson({required bool isPublish}) {
    return {
      "monthlyAidGoal": int.parse(monthlyAidGoal.text.trim()),
      // "attachedPlaylist": _mapPlaylistToIds(playlist.value),
      "title": compaignTitle.text.trim(),
      "cause": cause.text.trim(),
      "image": imageUrl.value,
      "statusId": isPublish ? 1 : 2,
    };
  }

  // Playlist mapping to backend IDs
  // List<int> _mapPlaylistToIds(String playlistName) {
  //   switch (playlistName) {
  //     case 'Umbrella':
  //       return [1];
  //     case 'Sky':
  //       return [2];
  //     case 'Fallen to earth':
  //       return [3];
  //     case 'God Given':
  //       return [4];
  //     default:
  //       return [1];
  //   }
  // }
}
