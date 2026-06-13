import 'package:travel_planner/core/constant/error_messages.dart'; // Import hằng số lỗi
import 'package:travel_planner/features/auth/domain/entities/user.dart';
import 'package:travel_planner/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;
  LoginUsecase({required this.authRepository});

  Future<User> execute(String phone, String password) async {
    if (phone.isEmpty || password.isEmpty) {
      throw Exception(ErrorMessages.phoneEmpty); // Sử dụng ở đây
    }
    if (phone.length < 10) {
      throw Exception(ErrorMessages.phoneInvalid); // Sử dụng ở đây
    }
    return await authRepository.login(phone, password);
  }
}
