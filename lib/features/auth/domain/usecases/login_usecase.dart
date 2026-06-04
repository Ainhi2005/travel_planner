import 'package:travel_planner/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:travel_planner/features/auth/domain/entities/user.dart';
import 'package:travel_planner/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginUsecase {
  final AuthRepository authRepository;
  LoginUsecase({required this.authRepository});
  Future<User> execute(String phone, String password) async {
    if (phone.isEmpty || password.isEmpty) {
      throw Exception('Số điện thoại và mật khẩu không được để trống');
    }
    if (phone.length < 10) {
      throw Exception('So dien thoai khong hop le');
    }
    return await authRepository.login(phone, password);
  }
}

final loginUsecaseProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LoginUsecase(authRepository: authRepository);
});
