// file này để xử lý phần
import 'package:travel_planner/core/network/api_client.dart';
import 'package:travel_planner/features/auth/data/models/user_ui_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String phone, String password);
  Future<UserModel> register(String name, String phone, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;
  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<UserModel> login(String phone, String password) async {
    final response = await _apiClient.dio.post(
      '/auth/login',
      data: {'phone': phone, 'password': password},
    );

    // 1. Lấy Map dữ liệu user từ key 'User' của Backend
    final userData = response.data['User'] as Map<String, dynamic>;

    // 2. Chuyển đổi (Map) các trường lệch về chuẩn mà UserModel của Flutter cần
    final mappedData = {
      'id': userData['id'].toString(), // Đổi int thành String
      'name': userData['username'], // Đổi username thành name
      'phone': userData['phone'],
      'avatarUrl': userData['avatar_url'], // Đổi avatar_url thành avatarUrl
    };

    return UserModel.fromJson(mappedData);
  }

  @override
  Future<UserModel> register(String name, String phone, String password) async {
    final response = await _apiClient.dio.post(
      '/auth/register',
      data: {'username': name, 'phone': phone, 'password': password},
    );

    final userData = response.data['User'] as Map<String, dynamic>;

    final mappedData = {
      'id': userData['id'].toString(),
      'name': userData['username'],
      'phone': userData['phone'],
      'avatarUrl': userData['avatar_url'],
    };

    return UserModel.fromJson(mappedData);
  }
}
