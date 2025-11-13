import 'package:musit/services/api_service.dart';

class PaymentService {
  final _api = ApiService();

  Future<Map<String, dynamic>> initPaymentApi(
      {required double amount, required int charityId}) async {
    return await _api
        .post("paypal/create", {"amount": amount, "charityId": charityId});
  }
}
