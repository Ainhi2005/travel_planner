import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    super.phone,
    super.avatar,
    super.bio,
    required super.language,
    required super.darkMode,
    super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      language: json['language'] as String? ?? 'vi',
      darkMode: json['dark_mode'] as bool? ?? false,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'bio': bio,
      'language': language,
      'dark_mode': darkMode,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
