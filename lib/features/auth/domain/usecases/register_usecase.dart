import 'package:travel_planner/features/auth/domain/entities/user.dart';
import 'package:travel_planner/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository authRepository;
  RegisterUsecase({required this.authRepository});
  Future<User> execute(String username, String phone, String password) async {
    if (username.isEmpty) {
      throw Exception('Tên đăng nhập không được để trống');
    }
    if (phone.isEmpty || phone.length < 10) {
      throw Exception('Số điện thoại không hợp lệ');
    }
    if (password.isEmpty || password.length < 6) {
      throw Exception('Mật khẩu phải có ít nhất 6 ký tự');
    }
    return await authRepository.register(username, phone, password);
  }
}