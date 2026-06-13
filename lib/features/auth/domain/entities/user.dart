class User {
  final int id;
  final String username;
  final String phone;
  final String? avatarUrl;
  User({
    required this.id,
    required this.username,
    required this.phone,
    this.avatarUrl,
  });
}
