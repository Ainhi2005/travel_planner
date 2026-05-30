import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();
  ApiClient() {
    _dio.options = BaseOptions(
      baseUrl: 'http://10.0.2.2:3000/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: Headers.jsonContentType,
    );
    _dio.interceptors.add(
      // bộ giám sát , chặn
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ), // hiện lên khi debug
    );
  }
  Dio get dio => _dio; // get để class khác dùng
  // không dùng public tránh bị class khác thay đổi _dio
}
