import 'package:get/get.dart';
import 'package:musit/globalModels/presaved_receipents.dart';
import 'package:musit/globalModels/song_model.dart';

import '../constants/app_enums.dart';

class CartModel {
  RxList<SongModel> songs;
  RxList<Map<AudioKey, dynamic>> voices;
  RxList<PreSavedRecipient> defaultRecipientIds;

  CartModel(
      {RxList<SongModel>? songs,
      RxList<Map<AudioKey, dynamic>>? voices,
      RxList<PreSavedRecipient>? defaultRecipientIds})
      : songs = songs ?? <SongModel>[].obs,
        voices = voices ?? <Map<AudioKey, dynamic>>[].obs,
        defaultRecipientIds = defaultRecipientIds ?? <PreSavedRecipient>[].obs;

  Map<String, dynamic> toMap() {
    return {
      'songs': songs.map(
        (song) {
          // If it's an Apple Music song, convert to public Apple Music URL format
          if (song.typeId == 3) {
            final publicUrl = _convertToPublicAppleMusicUrl(song);
            return {
              "typeId": song.typeId,
              "name": song.name,
              "link": publicUrl,
            };
          }
          // For other song types, use toJson as normal
          return song.toJson();
        },
      ).toList(),
      if (voices.isNotEmpty)
        'voiceNotes': voices
            .map((e) => {'name': e[AudioKey.name], 'link': e[AudioKey.path]})
            .toList(),
      if (defaultRecipientIds.isNotEmpty)
        'defaultRecipientIds': defaultRecipientIds
            .map(
              (user) => user.id,
            )
            .toList(),
    };
  }
}

String _convertToPublicAppleMusicUrl(SongModel song) {
  if (song.typeId != 3 || song.link == null || song.link!.isEmpty) {
    return song.link ?? '';
  }

  String link = song.link!;

  // Extract catalog ID if present in format: link|catalog:ID
  String? catalogId;
  if (link.contains('|catalog:')) {
    final parts = link.split('|catalog:');
    link = parts[0]; // Get the base link part
    if (parts.length > 1) {
      catalogId = parts[1];
    }
  }

  // If we have a valid catalog ID, convert to public Apple Music URL
  if (catalogId != null &&
      catalogId.isNotEmpty &&
      _isNumericCatalogId(catalogId)) {
    // Generate public Apple Music URL format: https://music.apple.com/[country]/song/id/[catalog-id]
    // Using 'us' as default country code (can be made configurable based on user's region)
    // Format: https://music.apple.com/us/song/id/[catalog-id]
    return 'https://music.apple.com/us/song/id/$catalogId';
  }

  // If no valid catalog ID found, we can't create a public Apple Music URL
  // Return the original link as-is (it will be the API URL format)
  return song.link ?? '';
}

bool _isNumericCatalogId(String id) {
  if (id.isEmpty) return false;
  return RegExp(r'^\d+$').hasMatch(id);
}
