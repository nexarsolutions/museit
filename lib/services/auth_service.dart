import 'package:get/get.dart';
import 'package:musit/globalModels/user_model.dart';
import 'package:musit/services/api_service.dart';

class AuthService {
  final _api = ApiService();

  ///Email already exists
  ///[data] holds body
  ///post function
  ///
  Future<Map<String, dynamic>> emailAlreadyExists(
      {required String email, required String phone}) async {
    String url = "user/isExists";

    var body = {
      if (email != '') "email": email,
      if (phone != '') "phone": phone
    };
    return await _api.post(url, body);
  }

  Future<Map<String, dynamic>> signupViaEmail(Map<String, dynamic> data) async {
    return await _api.post('signupViaEmail', data);
  }

  Future<Map<String, dynamic>> login(
      {required String email, required String password}) async {
    return await _api.post('loginUser', {'email': email, 'password': password});
  }

  Future<Map<String, dynamic>> getAllUserApi(
      {int? limit = 10,
      int? offset = 1,
      int? roleId,
      String search = ''}) async {
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

    if (roleId != null) {
      queryParams['roleId'] = roleId.toString();
    }

    if (search != '') {
      queryParams['search'] = search;
    }

    // Construct URL with query parameters
    String url = "users/all";
    if (queryParams.isNotEmpty) {
      final queryString = queryParams.entries
          .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value)}')
          .join('&');
      url += '?$queryString';
    }

    return await _api.get(url);
  }

  ///getUserInfoById
  ///
  Future<Map<String, dynamic>> getUserInfoById({required int userId}) async {
    return await _api.get("getUserInfoById?userId=$userId");
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    return await _api.put("updateProfile", data);
  }

  Future<Map<String, dynamic>> updatePassword(Map<String, dynamic> data) async {
    return await _api.put("updatePassword", data);
  }

  Future<Map<String, dynamic>> createCharityProfile(
      Map<String, dynamic> data) async {
    return await _api.post("user/charity", data);
  }

  Future<Map<String, dynamic>> charityDashboard() async {
    return await _api.get("/user/charity/dashboard");
  }

  ///******************** Function **********************
  ///
  Future<List<UserModel>> getAllUsers(
      {String search = '', int limit = 10, int offset = 1, int? roleId}) async {
    try {
      List<UserModel> userList = [];
      await _api.handleGetResponse(
        apiMethod: () => getAllUserApi(
            search: search, limit: limit, offset: offset, roleId: roleId),
        onSuccess: (response) {
          final receiptResponseModel = ReceiptResponseModel.fromJson(response);
          final newUserList = receiptResponseModel.response?.users ?? [];
          userList.assignAll(newUserList);
        },
        onError: (error) {
          throw Exception(error);
        },
      );
      return userList;
    } catch (e) {
      rethrow;
    }
  }
}
