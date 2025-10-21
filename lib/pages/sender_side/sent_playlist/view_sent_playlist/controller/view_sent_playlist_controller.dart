import 'package:get/get.dart';
import 'package:musit/globalModels/playlist_model.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/services/paylist_service.dart';

class ViewSentPlaylistController extends GetxController {
  final _apiService = ApiService();
  final _playlistService = PlaylistService();

  Future<PlaylistModel?> getPlayListById([int? playListId]) async {
    try {
      PlaylistModel? playlist;

      await _apiService.handleGetResponse(
        apiMethod: () =>
            _playlistService.playListById(playListId: playListId ?? -1),
        onSuccess: (success) {
          final response = success['response'];
          if (response != null) {
            playlist = PlaylistModel.fromJson(response);
          }
        },
        onError: (error) {
          throw Exception(error);
        },
      );

      return playlist;
    } catch (e) {
      rethrow;
    }
  }
}
