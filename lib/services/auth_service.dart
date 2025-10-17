import 'package:musit/services/api_service.dart';

class AuthService {
  final _api = ApiService();

  Future<Map<String, dynamic>> signupViaEmail(Map<String, dynamic> data) async {
    return await _api.post('signupViaEmail', data);
  }

  Future<Map<String, dynamic>> login(
      {required String email, required String password}) async {
    return await _api.post('loginUser', {'email': email, 'password': password});
  }
}
