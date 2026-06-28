import 'package:travel_planner/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(String fullName, String email, String password);
  Future<void> logout();
  Future<String?> getAcessToken();
  Future<void> saveToken(String accessToken, String refreshToken);
}

