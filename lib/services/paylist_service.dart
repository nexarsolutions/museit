import 'package:get/get.dart';
import 'package:musit/common_models/recipients_model.dart';
import 'package:musit/globalModels/playlist_model.dart';
import 'package:musit/services/api_service.dart';

import '../globalModels/recipient_response_model.dart';

class PlaylistService {
  final _api = ApiService();

  ///****************** APIs ********************
  ///
  Future<Map<String, dynamic>> playlists(
      {int? limit = 10, int? offset = 1}) async {
    // Build query parameters
    final Map<String, String> queryParams = {};

    if (limit != null && limit > 0) {
      queryParams['limit'] = limit.toString();
    }

    if (offset != null && offset >= 0) {
      offset--;

      ///is for front end i am using current page 1, offset 1
      queryParams['offset'] = offset.toString();
    }

    // Construct URL with query parameters
    String url = "playlists";
    if (queryParams.isNotEmpty) {
      final queryString = queryParams.entries
          .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value)}')
          .join('&');
      url += '?$queryString';
    }

    return await _api.get(url);
  }

  ///fetch paid songs
  /// type id 3 for paid songs
  ///
  Future<Map<String, dynamic>> getPaidSongs(
      {int typeId = 3, String search = ''}) async {
    // Build query parameters
    final Map<String, String> queryParams = {};

    if (typeId > 0) {
      queryParams['typeId'] = typeId.toString();
    }
    if (search != '') {
      queryParams['search'] = search.toString();
    }

    // Construct URL with query parameters
    String url = "songs/paid";
    if (queryParams.isNotEmpty) {
      final queryString = queryParams.entries
          .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value)}')
          .join('&');
      url += '?$queryString';
    }

    return await _api.get(url);
  }

  ///create a playlist
  ///
  Future<Map<String, dynamic>> createPlaylist(Map<String, dynamic> data) async {
    return await _api.post("playlist", data);
  }

  Future<Map<String, dynamic>> playListById({required int playListId}) async {
    return await _api.get("playlist?playlistId=$playListId");
  }

  Future<Map<String, dynamic>> sentPlaylistApi() async {
    return await _api.get("playlist/sent");
  }

  Future<Map<String, dynamic>> playlistRecipients({int? playlistId}) async {
    return await _api.get("playlist/recipients?playlistId=$playlistId");
  }

  Future<Map<String, dynamic>> share(
      {required List<int> toUserIds, int? typeId, int? id}) async {
    var data = {
      "typeId": typeId, //1-Playlist, 2-PaidSongs
      "playlistId": id,
      // "voiceNoteId": 5,
      "toUserIds": toUserIds.map((e) => e).toList()
    };

    return await _api.post("share", data);
  }

  ///******************** Function **********************
  ///
  Future<List<PlaylistModel>> getPlayList() async {
    try {
      List<PlaylistModel> playLists = [];
      await _api.handleGetResponse(
        apiMethod: () => playlists(),
        onSuccess: (response) {
          final playlistResponseModel =
              PlaylistResponseModel.fromJson(response);
          final newPlaylists = playlistResponseModel.response?.playLists ?? [];
          playLists.assignAll(newPlaylists);
        },
        onError: (error) {
          throw Exception(error);
        },
      );
      return playLists;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RecipientUserModel>> getPlaylistRecipientUsers({int? playlistId}) async {
    try {
      List<RecipientUserModel> userList = [];
      await _api.handleGetResponse(
        apiMethod: () => playlistRecipients(playlistId: playlistId),
        onSuccess: (response) {
          final receiptResponseModel =
              RecipientResponseModel.fromJson(response);
          final newUserList =
              receiptResponseModel.response?.recipientUsers ?? [];
          userList.assignAll(newUserList);
        },
        onError: (error) {
          throw Exception(error);
        },
      );
      return userList;
    } catch (e) {
      rethrow;
    }
  }
}
