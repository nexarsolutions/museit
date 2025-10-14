//Created by MansoorSatti 7/18/2025
class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}

class AuthException extends ApiException {
  AuthException(super.message);
}

class NetworkException extends ApiException {
  NetworkException(super.message);
}

class ServerException extends ApiException {
  ServerException(super.message);
}