import 'user_model.dart';

class UserResponseModel {
  final bool success;
  final String message;
  final UserModel? user;

  UserResponseModel({
    required this.success,
    required this.message,
    this.user,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}
