import 'package:get/get.dart';
import 'package:musit/services/api_service.dart';
import 'package:musit/services/auth_service.dart';


class CharityHomeController extends GetxController {
  Future<Map<String, dynamic>?> charityOverview() async {
    try {
      Map<String, dynamic>? response;
      await ApiService().handleGetResponse(
        apiMethod: () => AuthService().charityDashboard(),
        onSuccess: (success) {
          response = success['response'];
        },
        onError: (error) {
          throw Exception(error);
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
