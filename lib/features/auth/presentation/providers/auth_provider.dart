import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:travel_planner/features/auth/domain/repositories/auth_repository.dart';
import 'package:travel_planner/features/auth/domain/usecases/login_usecase.dart';
import 'package:travel_planner/features/auth/domain/usecases/register_usecase.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_state.dart';
export 'package:travel_planner/features/auth/presentation/providers/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUsecase loginUseCase;
  final RegisterUsecase registerUseCase;
  final AuthRepository authRepository;
  AuthNotifier({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.authRepository,
  }) : super(
         AuthState(),
       ); //Dấu hai chấm này được dùng để gọi và truyền giá trị mặc định vào Constructor của Class cha (Class StateNotifier).

  Future<void> login(String phone, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await loginUseCase.execute(phone, password);
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

  Future<void> register(String username, String phone, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final user = await registerUseCase.execute(username, phone, password);
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

  Future<void> logout() async {
    await authRepository.logout();
    state = AuthState();
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUseCase = ref.watch(loginUsecaseProvider);
  final registerUseCase = ref.watch(registerUseCaseProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(
    loginUseCase: loginUseCase,
    registerUseCase: registerUseCase,
    authRepository: authRepository,
  );
});

final authNotifierProvider = authProvider;
