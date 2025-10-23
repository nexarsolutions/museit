import 'package:musit/services/api_service.dart';

class HealthSupportService {
  final _api = ApiService();

  Future<Map<String, dynamic>> getHealthSupportApi(
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
    String url = "health/supports";
    if (queryParams.isNotEmpty) {
      final queryString = queryParams.entries
          .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value)}')
          .join('&');
      url += '?$queryString';
    }

    return _api.get(url);
  }
}
