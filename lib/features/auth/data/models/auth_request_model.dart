// request = gửi lên
// đọc từ json gửi lên có những gì thì model có những cái đấy
class LoginRequestModel {
  final String phone;
  final String password;
  LoginRequestModel({required this.phone, required this.password});
  Map<String, dynamic> toJson() {
    return {'phone':phone,'password':password};
  }
}

class RegisterRequestModel {
  final String phone;
  final String username;
  final String password;
  RegisterRequestModel({required this.phone,required this.username, required this.password});
  Map<String,dynamic> toJson() {
    return {'phone':phone,'username':username,'password':password};
  }
}
