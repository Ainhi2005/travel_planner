import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_ui_model.freezed.dart';
part 'user_ui_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
    required String phone,
    // Nếu trên cụm JSON không có hoặc bị null, tự động lấy link ảnh mặc định
    @Default(
      'https://res.cloudinary.com/dcapucva9/image/upload/v1763193948/meme-hai-29_epkzgk.jpg',
    )
    String avatarUrl,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
