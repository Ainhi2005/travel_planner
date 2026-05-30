// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_ui_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  name: json['name'] as String,
  phone: json['phone'] as String,
  avatarUrl:
      json['avatarUrl'] as String? ??
      'https://res.cloudinary.com/dcapucva9/image/upload/v1763193948/meme-hai-29_epkzgk.jpg',
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'avatarUrl': instance.avatarUrl,
    };
