// request = gửi lên
// đọc từ json gửi lên có những gì thì model có những cái đấy
class LoginRequestModel {
  final String email;
  final String password;
  LoginRequestModel({required this.email, required this.password});
  Map<String, dynamic> toJson() {
    return {'email':email,'password':password};
  }
}

class RegisterRequestModel {
  final String email;
  final String fullname;
  final String password;
  RegisterRequestModel({required this.email,required this.fullname, required this.password});
  Map<String,dynamic> toJson() {
    return {'email':email,'full_name':fullname,'password':password};
  }
}
