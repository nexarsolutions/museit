import 'package:musit/services/api_service.dart';

class AuthService {
  final _api = ApiService();

  Future<Map<String, dynamic>> signupViaEmail(Map<String, dynamic> data) async {
    return await _api.post('signupViaEmail', data);
  }
}
