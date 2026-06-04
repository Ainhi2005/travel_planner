import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/core/providers/core_providers.dart';
import 'package:travel_planner/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:travel_planner/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:travel_planner/features/auth/data/models/auth_request_model.dart';
import 'package:travel_planner/features/auth/domain/entities/user.dart';
import 'package:travel_planner/features/auth/domain/repositories/auth_repository.dart';

final authRemoteDataSourceprovider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRemoteDatasource(apiClient.dio);
});

final authRepositoryProvider = Provider((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceprovider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  return AuthRepositoryImpl(
    remoteDatasource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDatasource,
    required this.localDataSource,
  });

  @override
  Future<User> login(String phone, String password) async {
    final request = LoginRequestModel(phone: phone, password: password);
    final response = await remoteDatasource.login(request);
    if (response.success && response.accessToken != null) {
      await saveToken(response.accessToken!, response.refreshToken!);
      return response.user!.toEntity();
    } else {
      throw Exception(response.message);
    }
  }

  @override
  Future<User> register(String username, String phone, String password) async {
    final request = RegisterRequestModel(
      phone: phone,
      username: username,
      password: password,
    );
    final response = await remoteDatasource.register(request);
    if (response.success && response.user != null) {
      return response.user!.toEntity();
    } else {
      throw Exception(response.message);
    }
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
// 