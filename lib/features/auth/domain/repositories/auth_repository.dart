import 'package:travel_planner/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String phone, String password);
  Future<User> register(String username, String phone, String password);
  Future<void> logout();
  Future<String?> getAcessToken();
  Future<void> saveToken(String accessToken, String refreshToken);
}
