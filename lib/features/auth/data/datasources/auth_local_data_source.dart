//Lưu trữ, Đọc ra và Xóa thông tin người dùng ngay trên thiết bị di động.
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_planner/features/auth/data/models/user_ui_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearUser();
  // xử lý phần nhớ mật khẩu
  //....
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const _userKey = 'cached_user';
  @override
  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance(); // khởi tạo
    final jsonString = jsonEncode(user.toJson());
    //.tojson() : từ model -> Map<String, dymic>
    // jsonEncode : từ Map<String, dymic> -> String dạng json
    // setString : lưu string vào bộ nhớ
    await prefs.setString(_userKey, jsonString);
  }

  @override
  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_userKey);
    //.getstring() : lấy chuỗi từ bộ nhớ
    // lúc này jsonString có dạng "{}" (string)
    // null: không có ai đăng nhập
    if (jsonString == null) {
      return null;
    }
    return UserModel.fromJson(jsonDecode(jsonString));
    //jsonDecode : từ String dạng json -> Map<String, dymic>
    //fromJson : từ Map<String, dymic> -> model để trả về dạng model
  }

  @override
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
