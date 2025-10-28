// controllers/received_songs_controller.dart
import 'package:get/get.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/services/song_service.dart';
import '../../../../globalModels/receive_songs_model.dart';

class ReceivedSongsController extends GetxController {
  final isLoading = false.obs;
  final isPaginating = false.obs;
  final errorMessage = ''.obs;
  final receivedSongs = <ReceiveSongModel>[].obs;

  // Pagination tracking
  final currentPage = 1.obs;
  final limit = 10;
  bool hasMore = true;

  @override
  void onInit() {
    super.onInit();
    fetchReceivedSongs();
  }

  /// 🧩 Base Fetch Function
  Future<void> fetchReceivedSongs({bool refresh = false}) async {
    if (refresh) {
      currentPage.value = 1;
      hasMore = true;
      receivedSongs.clear();
    }

    if (isLoading.value || isPaginating.value || !hasMore) return;

    if (currentPage.value == 1) {
      isLoading.value = true;
    } else {
      isPaginating.value = true;
    }

    try {
      await ApiService().handleGetResponse(
        apiMethod: () => SongService()
            .receivedSongsApi(limit: limit, offset: currentPage.value),
        onSuccess: (success) {
          final data = ReceivedSongsResponseModel.fromJson(success);

          if (data.statusCode == 200 && data.response != null) {
            final newSongs = data.response?.rows ?? [];

            if (newSongs.isEmpty || newSongs.length < limit) {
              hasMore = false;
            }

            receivedSongs.addAll(newSongs);
            currentPage.value++;
          } else {
            errorMessage.value = data.message ?? 'No songs found.';
            hasMore = false;
          }
        },
        onError: (error) {
          errorMessage.value = error;
        },
      );
    } catch (e) {
      errorMessage.value = 'Error fetching songs: $e';
    } finally {
      isLoading.value = false;
      isPaginating.value = false;
    }
  }

  /// 🔄 Refresh list manually
  Future<void> refreshList() async {
    await fetchReceivedSongs(refresh : true);
  }
}
