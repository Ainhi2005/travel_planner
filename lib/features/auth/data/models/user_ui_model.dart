class UserUIModel {
  final String id;
  final String name;
  final String email;
  final String? avatar;

  const UserUIModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });
}
