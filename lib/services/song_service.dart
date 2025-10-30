import 'package:get/get.dart';
import 'package:musit/services/api_service.dart';
import '../globalModels/song_model.dart';

class SongService {
  final _api = ApiService();

  ///share songs
  ///
  Future<Map<String, dynamic>> shareSongs(Map<String, dynamic> songs) async {
    return await _api.post('songs/share', songs);
  }

  Future<Map<String, dynamic>> receivedSongsApi(
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
    String url = "songs/shared/received";
    if (queryParams.isNotEmpty) {
      final queryString = queryParams.entries
          .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value)}')
          .join('&');
      url += '?$queryString';
    }

    return await _api.get(url);
  }

  Future<Map<String, dynamic>> loadAdminSongs(
      {int? limit = 10, int? offset = 1, String search = ''}) async {
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

    if (search != '') {
      queryParams['search'] = search;
    }

    // Construct URL with query parameters
    String url = "admin/songs";
    if (queryParams.isNotEmpty) {
      final queryString = queryParams.entries
          .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value)}')
          .join('&');
      url += '?$queryString';
    }

    return await _api.get(url);
  }

  Future<Map<String, dynamic>> sentSongsApi(
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
    String url = "songs/shared/sent";
    if (queryParams.isNotEmpty) {
      final queryString = queryParams.entries
          .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value)}')
          .join('&');
      url += '?$queryString';
    }

    return await _api.get(url);
  }
}

/*nerkigukni@necub.com*/

/*jamlavudro@necub.com museit*/
