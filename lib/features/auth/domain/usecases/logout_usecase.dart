import 'package:travel_planner/features/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository authRepository;
  LogoutUsecase({required this.authRepository});
  Future<void> execute() async {
    await authRepository.logout();
  }
}
