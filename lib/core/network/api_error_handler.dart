import 'package:dio/dio.dart';
import '../constant/error_messages.dart';

class ApiErrorHandler {
  // Biến hàm này thành hàm static để dùng chung ở mọi nơi
  static String getErrorMessage(DioException e) {
    if (e.response?.data != null) {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        return data['message'] ?? ErrorMessages.genericServerError;
      }
      return '${ErrorMessages.genericServerError} (${e.response?.statusCode})';
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ErrorMessages.connectionTimeout;
      case DioExceptionType.connectionError:
        return ErrorMessages.connectionError;
      case DioExceptionType.cancel:
        return ErrorMessages.requestCancelled;
      default:
        return ErrorMessages.serverMaintenance;
    }
  }
}
