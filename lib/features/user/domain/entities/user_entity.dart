class UserEntity {
  final String id;
  final String fullName;
  final String email;
  final String? phone;
  final String? avatar;
  final String? bio;
  final String language;
  final bool darkMode;
  final String? createdAt;
  final String? updatedAt;

  UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone,
    this.avatar,
    this.bio,
    required this.language,
    required this.darkMode,
    this.createdAt,
    this.updatedAt,
  });
}