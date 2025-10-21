import 'package:get/get.dart';
import 'package:musit/globalModels/playlist_model.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/services/paylist_service.dart';

import '../../../../../globalModels/song_model.dart';

class SenderCreatedPlaylistController extends GetxController {
  final _apiService = ApiService();
  final _palylistService = PlaylistService();

  List<SongModel> songsList = [];

  Future<List<SongModel>> getPlayListById([int? playListId]) async {
    List<SongModel> songs = [];
    try {
      await _apiService.handleGetResponse(
        apiMethod: () =>
            _palylistService.playListById(playListId: playListId ?? (-1)),
        onSuccess: (success) {
          final response = success['response'];
          if (response != null) {
            final playlist = PlaylistModel.fromJson(response);
            songs = playlist.songs;
          }
        },
        onError: (error) {
          throw Exception(error);
        },
      );

      return songs;
    } catch (e) {
      rethrow;
    }
  }
}
