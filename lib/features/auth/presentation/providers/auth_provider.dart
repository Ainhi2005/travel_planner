import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:travel_planner/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:travel_planner/features/auth/domain/entities/user.dart';
import 'package:travel_planner/features/auth/domain/usecases/login_usecase.dart';
import 'package:travel_planner/features/auth/domain/usecases/logout_usecase.dart';
import 'package:travel_planner/features/auth/domain/usecases/register_usecase.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_state.dart';
export 'package:travel_planner/features/auth/presentation/providers/auth_state.dart';

/// LỚP QUẢN LÝ TRẠNG THÁI XÁC THỰC (AUTHENTICATION NOTIFIER)
/// Công dụng: Nắm giữ trạng thái đăng nhập/đăng ký/đăng xuất (AuthState) và
/// cung cấp các hàm (methods) để UI (Giao diện) gọi xử lý logic.
class AuthNotifier extends StateNotifier<AuthState> {
  // Các Use Case (Ca sử dụng) chứa logic nghiệp vụ cốt lõi từ tầng Domain.
  // Không xử lý trực tiếp API ở đây, mà gọi qua các Use Case này.
  final LoginUsecase loginUseCase;
  final RegisterUsecase registerUseCase;
  final LogoutUsecase logoutUseCase;
  final AuthLocalDataSource authLocalDataSource;

  // Constructor: Yêu cầu truyền vào 3 Use Case bắt buộc khi khởi tạo.
  // `: super(AuthState())` dùng để khởi tạo trạng thái mặc định ban đầu cho StateNotifier
  // (Ví dụ: lúc mới mở app thì isLoading = false, user = null, isAuthenticated = false).
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
      // 1. Nếu có token, móc tiếp cục User dưới local lên
      final userStr = await authLocalDataSource.getUserJson();
      User? savedUser;

      if (userStr != null) {
        // Dịch từ chuỗi JSON về lại đối tượng User
        final Map<String, dynamic> userMap = jsonDecode(userStr);
        savedUser = User(
          id: userMap['id'],
          username: userMap['username'],
          phone: userMap['phone'],
          avatarUrl: userMap['avatarUrl'],
        );
      }
      // Gắn user vừa lấy được vào trạng thái
      state = state.copyWith(
        isAuthenticated: true,
        isLoading: false,
        user: savedUser,
      );
    } else {
      state = state.copyWith(isAuthenticated: false, isLoading: false);
    }
  }

  Future<void> login(String phone, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final user = await loginUseCase.execute(phone, password);

      // 2. Ngay khi đăng nhập thành công, nén User thành JSON và tống xuống bộ nhớ Local
      final userJsonString = jsonEncode({
        'id': user.id,
        'username': user.username,
        'phone': user.phone,
        'avatarUrl': user.avatarUrl,
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

  /// HÀM XỬ LÝ ĐĂNG KÝ TÀI KHOẢN MỚI
  /// Mục đích: Nhận thông tin từ UI -> Tạo tài khoản -> Tự động đăng nhập nếu thành công.
  Future<void> register(String username, String phone, String password) async {
    // Bước 1: Bật trạng thái loading và xóa lỗi cũ.
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // Bước 2: Gọi Use Case thực hiện đăng ký tài khoản mới.
      final user = await registerUseCase.execute(username, phone, password);

      // Bước 3: Đăng ký thành công -> Cập nhật state cho phép user vào thẳng app luôn.
      state = state.copyWith(
        isLoading: false,
        user: user,
        isAuthenticated: true,
      );
    } catch (e) {
      // Bước 4: Đăng ký thất bại (ví dụ: số điện thoại đã tồn tại) -> Lưu lại lỗi để UI hiển thị.
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  /// HÀM XỬ LÝ ĐĂNG XUẤT
  /// Mục đích: Xóa session/token và đưa trạng thái ứng dụng về ban đầu.
  Future<void> logout() async {
    // Bước 1: Gọi Use Case thực hiện xóa token ở local storage hoặc gọi API logout phía Server.
    await logoutUseCase.execute();

    // Bước 2: Reset trạng thái (state) về rỗng (trạng thái ban đầu giống như khi mới mở app).
    state = AuthState();
  }

  /// HÀM XÓA LỖI TẠM THỜI
  /// Mục đích: Xóa thông báo lỗi trong state về `null`.
  /// Thường dùng khi: User bấm nút "Đóng" trên Dialog báo lỗi, hoặc khi chuyển từ màn Login sang Register.
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

// ==========================================
// CÁC PROVIDERS (HỆ THỐNG QUẢN LÝ PHỤ THUỘC CỦA RIVERPOD)
// ==========================================

/// Provider cung cấp thực thể LoginUsecase.
/// Nó 'watch' (theo dõi) authRepositoryProvider để lấy dữ liệu kho lưu trữ (Repository) nạp vào cho UseCase.
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
