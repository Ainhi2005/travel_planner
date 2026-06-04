import 'package:travel_planner/core/network/api_endpoints.dart';
import 'package:travel_planner/features/auth/data/models/auth_request_model.dart';
import 'package:travel_planner/features/auth/data/models/auth_response_model.dart';
import 'package:dio/dio.dart';

class AuthRemoteDatasource {
  final Dio dio;
  AuthRemoteDatasource(this.dio);
  Future<AuthResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await dio.post(
        ApiEndpoints.login,
        data: request.toJson(),
      );
      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_getErrorMessage(e));
    }
  }

  Future<AuthResponseModel> register(RegisterRequestModel request) async {
    try {
      final response = await dio.post(
        ApiEndpoints.register,
        data: request.toJson(),
      );
      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_getErrorMessage(e));
    }
  }

  String _getErrorMessage(DioException e) {
    // 1. Nếu có phản hồi từ Server
    if (e.response?.data != null) {
      final data = e.response?.data;

      // Kiểm tra chắc chắn data trả về là Map (JSON) thì mới lấy ['message']
      if (data is Map<String, dynamic>) {
        return data['message'] ?? 'Đã có lỗi xảy ra từ máy chủ';
      }

      // Nếu server trả về lỗi nhưng dạng chuỗi HTML hoặc chữ thuần túy
      return 'Lỗi hệ thống (${e.response?.statusCode})';
    }

    // 2. Nếu không có phản hồi từ Server (Lỗi kết nối, Timeout, Mất mạng)
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Kết nối quá hạn, vui lòng kiểm tra lại mạng của bạn';
      case DioExceptionType.connectionError:
        return 'Không thể kết nối tới máy chủ. Vui lòng kiểm tra internet';
      case DioExceptionType.cancel:
        return 'Yêu cầu kết nối đã bị hủy';
      default:
        // Trả về câu thông báo tiếng Việt dễ hiểu thay vì e.message tiếng Anh
        return 'Lỗi kết nối internet hoặc máy chủ đang bảo trì';
    }
  }
}
