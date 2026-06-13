import 'package:travel_planner/features/auth/data/models/user_model.dart';
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