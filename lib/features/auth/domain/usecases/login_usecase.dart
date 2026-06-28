
import 'package:travel_planner/features/auth/domain/entities/user_entity.dart';
import 'package:travel_planner/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;
  LoginUsecase({required this.authRepository});

  Future<UserEntity> execute(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email hoặc mật khẩu không được để trống'); 
    }
    if (!email.contains('@')) {
      throw Exception('Email không hợp lệ'); 
    }
    return await authRepository.login(email, password);
  }
}

