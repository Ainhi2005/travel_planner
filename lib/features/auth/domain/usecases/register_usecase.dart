import 'package:travel_planner/features/auth/domain/entities/user_entity.dart';
import 'package:travel_planner/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository authRepository;
  RegisterUsecase({required this.authRepository});
  Future<UserEntity> execute(String fullname, String email, String password) async {
    if (fullname.isEmpty) {
      throw Exception('Tên đăng nhập không được để trống');
    }
    if (password.isEmpty || password.length < 6) {
      throw Exception('Mật khẩu phải có ít nhất 6 ký tự, vui lòng nhập lại');
    }
    if (!email.contains('@')) {
      throw Exception('Email không hợp lệ, vui lòng nhập lại');
    }
    return await authRepository.register(fullname, email, password);
  }
}
