import 'package:get/get.dart';
import 'package:musit/common_models/recipients_model.dart';
import 'package:musit/globalModels/playlist_model.dart';
import 'package:musit/services/api_service.dart';

import '../globalModels/receive_playlist_response_model.dart';
import '../globalModels/recipient_response_model.dart';
import '../globalModels/song_model.dart';

class SongService {
  final _api = ApiService();

  ///share songs
  ///
  Future<Map<String, dynamic>> shareSongs(Map<String, dynamic> songs) async {
    return await _api.post('share', songs);
  }

// Future<Map<String, dynamic>> playlists(
//     {int? limit = 10, int? offset = 1}) async {
//   // Build query parameters
//   final Map<String, String> queryParams = {};
//
//   if (limit != null && limit > 0) {
//     queryParams['limit'] = limit.toString();
//   }
//
//   if (offset != null && offset >= 0) {
//     offset--;
//
//     ///is for front end i am using current page 1, offset 1
//     queryParams['offset'] = offset.toString();
//   }
//
//   // Construct URL with query parameters
//   String url = "playlists";
//   if (queryParams.isNotEmpty) {
//     final queryString = queryParams.entries
//         .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value)}')
//         .join('&');
//     url += '?$queryString';
//   }
//
//   return await _api.get(url);
// }
}
