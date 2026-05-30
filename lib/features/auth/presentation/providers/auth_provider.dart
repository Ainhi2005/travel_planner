/*
2. Nhiệm vụ của nó:
Khởi tạo và cung cấp Dependencies: Định nghĩa các Provider để tạo ra ApiClient, AuthLocalDataSource, AuthRemoteDataSource, và AuthRepository dưới dạng Singleton để toàn app sử dụng chung một đối tượng, tránh rò rỉ bộ nhớ.
Quản lý Trạng thái Đăng nhập (AuthNotifier):
Chứa biến state kiểu AsyncValue<UserModel?>. UI sẽ theo dõi biến này để tự đổi nút bấm thành vòng tròn xoay xoay (khi loading) hoặc hiện lỗi (khi error).
Tự động chạy hàm checkAuthStatus() ngay khi app mở lên để đọc dữ liệu trong máy. Nếu có user, app lập tức ở trạng thái đăng nhập thành công (state = AsyncValue.data(user)).
Cung cấp các hành động login, register, logout cho các nút bấm ở giao diện gọi.
 */
//1 tạo api provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/core/network/api_client.dart';
import 'package:travel_planner/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:travel_planner/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:travel_planner/features/auth/data/models/user_ui_model.dart';
import 'package:travel_planner/features/auth/data/repositories/auth_repository_impl.dart';

//1. tao api provider
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
// 2. Tạo Local Data Source Provider
final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl();
});
// 3. Tạo Remote Data Source Provider
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRemoteDataSourceImpl(apiClient);
});
// . Tạo Repository Provider (truyền cả remote và local datasource vào)
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
  final local = ref.watch(authLocalDataSourceProvider);
  return AuthRepositoryImpl(remote, local);
});

// 5. Thiết lập Notifier quản lý Trạng thái Auth
class AuthNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthRepository _repository;
  AuthNotifier(this._repository) : super(const AsyncValue.data(null)) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    state = const AsyncValue.loading();
    try {
      final user = await _repository.getCachedUser();
      state = AsyncValue.data(user);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // hàm thực hiện đăng nhập
  Future<void> login(String phone, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.login(phone, password);
    });
  }

  // hàm thực hiện đăng kí
  Future<void> register(String name, String phone, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.register(name, phone, password);
    });
  }

  // hàm thực hiện đăng xuất
  Future<void> logout() async {
    state = AsyncValue.loading();
    try {
      await _repository.logout();
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<UserModel?>>((ref) {
      final repository = ref.watch(authRepositoryProvider);
      return AuthNotifier(repository);
    });
