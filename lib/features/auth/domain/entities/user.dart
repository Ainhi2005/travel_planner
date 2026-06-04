class User {
  final int id;
  final String username;
  final String phone;
  final String? avatar_url;
  User({
    required this.id,
    required this.username,
    required this.phone,
    this.avatar_url,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      phone: json['phone'],
      avatar_url: json['avatar_url'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'phone': phone,
      'avatar_url': avatar_url,
    };
  }
}
