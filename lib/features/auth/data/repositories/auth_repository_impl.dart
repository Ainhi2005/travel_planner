//Repository làm nhiệm vụ giao tiếp giữa tầng dữ liệu và tầng UI/Logic. Nó quản lý việc xử lý lỗi (Try/Catch) và chuyển đổi dữ liệu.
import 'package:travel_planner/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:travel_planner/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:travel_planner/features/auth/data/models/user_ui_model.dart';

abstract class AuthRepository {
  Future<UserModel> login(String phone, String password);
  Future<UserModel> register(String name, String phone, String password);
  Future<UserModel?> getCachedUser();
  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  AuthRepositoryImpl(this._remoteDataSource, this._authLocalDataSource);
  @override
  Future<UserModel> login(String phone, String password) async {
    try {
      final user = await _remoteDataSource.login(phone, password);
      await _authLocalDataSource.saveUser(user);
      return user;
    } catch (e) {
      throw Exception('dang nhap that bai ,${e}');
    }
  }

  @override
  Future<UserModel> register(String name, String phone, String password) async {
    try {
      final user = await _remoteDataSource.register(name, phone, password);
      await _authLocalDataSource.saveUser(user);
      return user;
    } catch (e) {
      throw Exception('dang ki that bai, ${e}');
    }
  }

  @override
  Future<UserModel?> getCachedUser() {
    return _authLocalDataSource.getUser();
  }

  @override
  Future<void> logout() {
    return _authLocalDataSource.clearUser();
  }
}
