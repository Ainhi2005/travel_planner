import 'package:travel_planner/features/auth/domain/entities/user.dart';

class UserModel {
  final int id;
  final String username;
  final String phone;
  final String? avatar_url;
  
  UserModel({
    required this.id,
    required this.username,
    required this.phone,
    this.avatar_url,
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      phone: json['phone'] as String,
      avatar_url: json['avatar_url'] as String?,
    );
  }
  
  User toEntity() {
    return User(
      id: id,
      username: username,
      phone: phone,
      avatar_url: avatar_url,
    );
  }
}
class AuthResponseModel {
  
  final bool success;
  final String message;
  final String? accessToken;
  final String? refreshToken;
  final UserModel? user;
  
  AuthResponseModel({
    required this.success,
    required this.message,
    this.accessToken,
    this.refreshToken,
    this.user,
  });
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}