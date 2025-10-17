import 'package:get/get.dart';
import 'package:musit/globalModels/playlist_model.dart';
import 'package:musit/services/api_service.dart';

class PlaylistService {
  final _api = ApiService();

  ///****************** APIs ********************
  ///
  Future<Map<String, dynamic>> playlists(
      {int limit = 10, int? offset = 1}) async {
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
}
