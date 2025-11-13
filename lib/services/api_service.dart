import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:musit/pages/auth/login/login_screen.dart';
import 'package:musit/utils/dialog_utilities.dart';

import '../main.dart';
import '../utils/global_functions.dart';
import 'api_exception.dart';

class ApiService {
  static String baseUrl = 'http://3.10.169.217:8084/api/';
  static String serverUrl = 'http://3.10.169.217:8084/';
  static String youtubeApiKey = 'AQ'
      '.Ab8RN6LtM4Go5j7_GcTrtJGP9RV8mlp6MhfZCcuX32NU8DRVjA';

  static final String imageUrl = '${serverUrl}file/';

  ///get header with/without token
  Future<Map<String, String>> _getHeaders() async {
    var token = userManager.userApiToken;
    return {
      'Content-Type': 'application/json',
      if (token != null && token != '') 'Authorization': 'Bearer $token',
    };
  }

  ///handle responses
  Future<dynamic> _handleResponse(http.Response response) async {
    var result = jsonDecode(response.body);
    // customPrint(result.toString());
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return result;
    }

    // For error codes, use the 'message' from the backend if available
    // or provide a default if 'message' is not always present in error responses.
    final errorData = result is Map<String, dynamic> ? result : {};
    final errorMessage = errorData['message'] ?? 'An unknown error occurred.';

    if (response.statusCode == 401) {
      throw AuthException('Session expired. Please log in again.');
    }

    // Consider more granular 4xx error handling if your backend provides specific codes
    if (response.statusCode >= 400 && response.statusCode < 500) {
      // This catches all other 4xx errors not explicitly handled (like 400, 403, 404, 422)
      throw ApiException(errorMessage); // Use the backend's message
    }

    if (response.statusCode >= 500) {
      throw ServerException(
          'Unexpected API response: ${response.statusCode}. $errorMessage');
    }

    // Fallback for any other unexpected status codes
    throw ApiException(
        'Unexpected API response: ${response.statusCode}. $errorMessage');
  }

  ///get
  Future<T> get<T>(String path) async {
    try {
      printInfo(info: "****** get path: $path ******");
      final headers = await _getHeaders();
      final response =
          await http.get(Uri.parse('$baseUrl$path'), headers: headers);

      return await _handleResponse(response);
    } on SocketException {
      throw NetworkException('No internet connection');
    } on FormatException {
      throw ApiException('Invalid response format');
    }
  }

  Future<T> getWithBody<T>(String path, Map<String, dynamic> body) async {
    try {
      final headers = await _getHeaders();

      var uri = Uri.parse('$baseUrl$path');
      // customPrint('$_baseUrl$path');

      var request = http.Request('GET', uri);
      request.body = jsonEncode(body);
      request.headers.addAll(headers);

      final streamedResponse = await request.send();
      final responseString = await streamedResponse.stream.bytesToString();
      final response =
          http.Response(responseString, streamedResponse.statusCode);

      return await _handleResponse(response);
    } on SocketException {
      throw NetworkException('No internet connection');
    } on FormatException {
      throw ApiException('Invalid response format');
    }
  }

  ///post
  Future<dynamic> post(String path, Map<String, dynamic> data) async {
    try {
      printInfo(info: "$baseUrl$path");
      final headers = await _getHeaders();
      printInfo(info: "$headers");
      printInfo(info: "Body: $data");
      final response = await http.post(
        Uri.parse('$baseUrl$path'),
        headers: headers,
        body: jsonEncode(data),
      );
      return await _handleResponse(response);
    } on SocketException {
      throw NetworkException('No internet connection');
    } on FormatException {
      throw ApiException('Invalid response format');
    }
  }

  ///post with multipart file
  ///
  Future<Map<String, dynamic>> postMultipartFile({
    required String path,
    required String fieldName,
    required String filePath,
    Map<String, String>? additionalFields,
  }) async {
    try {
      final token = userManager.userApiToken;

      var uri = Uri.parse('$baseUrl$path');

      var request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers['Content-Type'] = 'multipart/form-data';
      if (token != null && token != '') {
        request.headers['Authorization'] = 'Bearer $token';
      }

      // Add file
      request.files.add(await http.MultipartFile.fromPath(fieldName, filePath));

      // Add extra fields if any
      if (additionalFields != null) {
        request.fields.addAll(additionalFields);
      }

      // Send the request
      final response =
          await request.send() /*.timeout(const Duration(seconds: 15))*/;

      final responseBody = await response.stream.bytesToString();
      final decodedResponse = jsonDecode(responseBody);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decodedResponse;
      }

      final errorMessage = decodedResponse['message'] ??
          'File upload failed with unknown error.';

      if (response.statusCode == 401) {
        Get.offAll(() => LoginScreen());

        await userManager.clearUser();
        throw AuthException('Session expired. Please log in again.');
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        throw ApiException(errorMessage);
      } else if (response.statusCode >= 500) {
        throw ServerException(
            'Server error (${response.statusCode}): $errorMessage');
      }

      throw ApiException('Unexpected status: ${response.statusCode}');
    } on SocketException {
      throw NetworkException('No internet connection');
    } on FormatException {
      throw ApiException('Invalid response format');
    }
  }

  ///put
  Future<dynamic> put(String path, dynamic data) async {
    try {
      final headers = await _getHeaders();
      final response = await http.put(
        Uri.parse('$baseUrl$path'),
        headers: headers,
        body: jsonEncode(data),
      );
      return await _handleResponse(response);
    } on SocketException {
      throw NetworkException('No internet connection');
    } on FormatException {
      throw ApiException('Invalid response format');
    }
  }

  ///delete
  Future<dynamic> delete(String path) async {
    try {
      final headers = await _getHeaders();
      final response =
          await http.delete(Uri.parse('$baseUrl$path'), headers: headers);
      return await _handleResponse(response);
    } on SocketException {
      throw NetworkException('No internet connection');
    } on FormatException {
      throw ApiException('Invalid response format');
    }
  }

  Future<void> handleResponse({
    required Future<Map<String, dynamic>> Function() apiMethod,
    String loadingMsg = "Processing...",
    Function(Map<String, dynamic>)? onSuccess,
  }) async {
    String? errorMessage;
    bool isDialogShown = false; // 🧩 track if we showed it

    try {
      loadingDialog(message: loadingMsg);
      isDialogShown = true;

      final response = await apiMethod();

      // Before calling onSuccess, close the loading dialog safely
      if (isDialogShown && (Get.isDialogOpen ?? false)) {
        Get.back();
        isDialogShown = false;
      }

      await onSuccess?.call(response);
    } on AuthException catch (e) {
      errorMessage = e.message;
      customPrint('Auth Error: $e');
      Get.offAll(() => LoginScreen());
      await userManager.clearUser();
    } on NetworkException catch (e) {
      errorMessage = e.message;
      customPrint('Network Error: $e');
    } on ApiException catch (e) {
      errorMessage = e.message;
      customPrint('API Error: $e');
    } catch (e) {
      errorMessage = e.toString();
      customPrint('Unknown Error: $e');
    } finally {
      // Close dialog ONLY if we opened it and it's still open
      if (isDialogShown && (Get.isDialogOpen ?? false)) {
        Get.back();
        isDialogShown = false;
      }

      // Show error (if any)
      if (errorMessage != null) {
        errorDialog(
          title: "Error",
          content: errorMessage,
        );
      }
    }
  }

  Future<void> handleGetResponse({
    required Future<Map<String, dynamic>> Function() apiMethod,
    Function(Map<String, dynamic>)? onSuccess,
    Function(String)? onError,
  }) async {
    String? errorMessage;
    try {
      final response = await apiMethod();

      onSuccess?.call(response);
    } on AuthException catch (e) {
      errorMessage = e.message;
      Get.offAll(() => LoginScreen());
      await userManager.clearUser();
      errorDialog(
        title: "Error",
        content: errorMessage,
      );
      customPrint('Auth Error: $e');
    } on NetworkException catch (e) {
      errorMessage = e.message;
      customPrint('Network Error: $e');
    } on ApiException catch (e) {
      errorMessage = e.message;
      customPrint('API Error: $e');
    } catch (e) {
      errorMessage = e.toString();
      customPrint('Unknown Error: $e');
    } finally {
      if (errorMessage != null) {
        onError?.call(errorMessage);
      }
    }
  }
}
