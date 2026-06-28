import 'package:travel_planner/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:travel_planner/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:travel_planner/features/auth/data/models/auth_request_model.dart';
import 'package:travel_planner/features/auth/domain/entities/user_entity.dart';
import 'package:travel_planner/features/auth/domain/repositories/auth_repository.dart';
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDatasource,
    required this.localDataSource,
  });

  @override
  Future<UserEntity> login(String email, String password) async {
    final request = LoginRequestModel(email: email, password: password);
    final response = await remoteDatasource.login(request);

    if (!response.success) {
      throw Exception(response.message);
    }
    await saveToken(response.accessToken!, response.refreshToken ?? '');
    return response.user!;
  }
  @override
  Future<UserEntity> register(String fullName, String email, String password) async {
    final request = RegisterRequestModel(
      email: email,
      fullname: fullName,
      password: password,
    );
    final response = await remoteDatasource.register(request);
    if (!response.success) {
      throw Exception(response.message);
    }
    if (response.user == null) {
      throw Exception('Dữ liệu người dùng trả về không hợp lệ.');
    }
    // Không tự động lưu token ở đây để bắt buộc user phải đăng nhập thủ công
    return response.user!;
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearTokens();
  }
  @override
  Future<String?> getAcessToken() async {
    return await localDataSource.getAccessToken();
  }

  @override
  Future<void> saveToken(String accessToken, String refreshToken) async {
    await localDataSource.saveAccessToken(accessToken);
    await localDataSource.saveRefreshToken(refreshToken);
  }
}
