// lib/features/auth/data/models/user_model.dart hoặc trong auth_response_model.dart
import '../../domain/entities/user.dart';

class UserModel {
  final int id;
  final String username;
  final String phone;
  final String? avatarUrl; // Có thể dùng camelCase cho đúng chuẩn Dart

  UserModel({
    required this.id,
    required this.username,
    required this.phone,
    this.avatarUrl,
  });

  // Chịu trách nhiệm parse JSON từ API (nếu API đổi key, chỉ sửa ở đây)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      phone: json['phone'] as String,
      avatarUrl: json['avatar_url'] as String?, // Map key của API
    );
  }

  // Hàm chuyển đổi Model sang Entity để trả về cho Domain/Presentation
  User toEntity() {
    return User(
      id: id,
      username: username,
      phone: phone,
      avatarUrl: avatarUrl,
    );
  }
}
