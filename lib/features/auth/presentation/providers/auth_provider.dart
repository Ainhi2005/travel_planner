import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/core/providers/core_providers.dart';
import 'package:travel_planner/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:travel_planner/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:travel_planner/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:travel_planner/features/auth/domain/entities/user_entity.dart';
import 'package:travel_planner/features/auth/domain/usecases/login_usecase.dart';
import 'package:travel_planner/features/auth/domain/usecases/logout_usecase.dart';
import 'package:travel_planner/features/auth/domain/usecases/register_usecase.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_state.dart';
export 'package:travel_planner/features/auth/presentation/providers/auth_state.dart';


class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUsecase loginUseCase;
  final RegisterUsecase registerUseCase;
  final LogoutUsecase logoutUseCase;
  final AuthLocalDataSource authLocalDataSource;

  AuthNotifier({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.authLocalDataSource,
  }) : super(AuthState(isLoading: true)) {
    checkToken();
  }

  Future<void> checkToken() async {
    final token = await authLocalDataSource.getAccessToken();
    if (token != null) {
      final userStr = await authLocalDataSource.getUserJson();
      UserEntity? savedUser;

      if (userStr != null) {
        final Map<String, dynamic> userMap = jsonDecode(userStr);
        savedUser = UserEntity(
          id: userMap['id'],
          fullName: userMap['fullName'],
          email: userMap['email'],
        );
      }
      
      state = state.copyWith(
        isAuthenticated: true,
        isLoading: false,
        user: savedUser,
      );
    } else {
      state = state.copyWith(isAuthenticated: false, isLoading: false);
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final user = await loginUseCase.execute(email, password);

      final userJsonString = jsonEncode({
        'id': user.id,
        'fullName': user.fullName,
        'email': user.email,
      });
      await authLocalDataSource.saveUserJson(userJsonString);

      state = state.copyWith(
        isLoading: false,
        user: user,
        isAuthenticated: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  Future<bool> register(String fullName, String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await registerUseCase.execute(fullName, email, password);

      // Không tự động đăng nhập (không set user, không set isAuthenticated)
      state = state.copyWith(isLoading: false);
      return true; // Trả về true báo hiệu thành công
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
      return false; // Trả về false báo hiệu lỗi
    }
  }

  Future<void> logout() async {
    await logoutUseCase.execute();
    state = AuthState();
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

// ==========================================
// CÁC PROVIDERS (HỆ THỐNG QUẢN LÝ PHỤ THUỘC CỦA RIVERPOD)
// ==========================================

// --- Tầng Data & Network ---
final authLocalDataSourceProvider = Provider((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return AuthLocalDataSource(secureStorage);
});

final authRemoteDataSourceProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRemoteDatasource(apiClient);
});

final authRepositoryProvider = Provider((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  return AuthRepositoryImpl(
    remoteDatasource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

// --- Tầng UseCase ---
/// Provider cung cấp thực thể LoginUsecase.
final loginUsecaseProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LoginUsecase(authRepository: authRepository);
});

/// Provider cung cấp thực thể RegisterUsecase.
final registerUseCaseProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return RegisterUsecase(authRepository: authRepository);
});

/// Provider cung cấp thực thể LogoutUsecase.
final logoutUsecaseProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LogoutUsecase(authRepository: authRepository);
});

/// TRUNG TÂM QUẢN LÝ CHÍNH (authProvider)
/// Dạng `StateNotifierProvider`: Lắng nghe lớp `AuthNotifier` và trả về trạng thái `AuthState`.
/// Công dụng: UI sẽ "watch" cái `authProvider` này để lấy trạng thái vẽ giao diện (như kiểm tra xem đã login chưa, có đang loading không).
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  // Lấy ra 3 Use Case đã được khai báo ở trên thông qua cơ chế Dependency Injection của Riverpod.
  final loginUseCase = ref.watch(loginUsecaseProvider);
  final registerUseCase = ref.watch(registerUseCaseProvider);
  final logoutUseCase = ref.watch(logoutUsecaseProvider);
  final authLocalDataSource = ref.watch(authLocalDataSourceProvider);

  // Khởi tạo và trả về AuthNotifier cùng với các tham số phụ thuộc của nó.
  return AuthNotifier(
    loginUseCase: loginUseCase,
    registerUseCase: registerUseCase,
    logoutUseCase: logoutUseCase,
    authLocalDataSource: authLocalDataSource,
  );
});

/// Bí danh (Alias) của authProvider.
/// Mục đích: Tạo ra một cái tên tường minh hơn (authNotifierProvider) để lập trình viên sử dụng khi muốn gọi các hàm xử lý bên trong Notifier (như .login(), .logout()).
final authNotifierProvider = authProvider;

