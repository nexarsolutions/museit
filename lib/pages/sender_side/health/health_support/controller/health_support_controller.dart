import 'package:get/get.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/services/health_support_service.dart';

import '../../../../../globalModels/health_support_response_model.dart';

class HealthSupportController extends GetxController {
  final _service = HealthSupportService();

  var healthSupportList = <HealthSupportModel>[].obs;
  var isLoading = false.obs;

  RxnString errorString = RxnString();
  var page = 1;
  var hasMore = true;

  final _apiservice = ApiService();

  @override
  void onInit() {
    super.onInit();
    getHealthSupports();
  }

  Future<void> getHealthSupports({bool refresh = false}) async {
    if (isLoading.value) return; // prevent duplicate requests

    if (refresh) {
      page = 1;
      hasMore = true;
      healthSupportList.clear();
    }

    if (!hasMore) return;

    try {
      isLoading.value = true;

      await _apiservice.handleGetResponse(
        apiMethod: () => _service.getHealthSupportApi(limit: 40, offset: page),
        onSuccess: (success) {
          final data = HealthSupportResponseModel.fromJson(success);
          final newItems = data.response?.healthSupporters ?? [];
          if (newItems.isEmpty) {
            hasMore = false;
          } else {
            healthSupportList.addAll(newItems);
            page++;
          }
          errorString.value=null;
        },
        onError: (error) {
          hasMore = false;
          errorString.value = error.toString();
        },
      );
    } catch (e) {
      hasMore = false;
      errorString.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
