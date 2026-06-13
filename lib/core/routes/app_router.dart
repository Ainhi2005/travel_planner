
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/routes/app_path.dart';
import 'package:travel_planner/features/auth/presentation/pages/login_page.dart';
import 'package:travel_planner/features/auth/presentation/pages/register_page.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_provider.dart';
import 'package:travel_planner/features/main/presentation/pages/main_page.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  return GoRouter(
    initialLocation: AppPath.home,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      if (authState.isLoading) return null;
      final isAuth = authState.isAuthenticated;
      final isGoingLogin =
          state.uri.toString() == AppPath.login ||
          state.uri.toString() == AppPath.register;
      if (!isAuth && !isGoingLogin) {
        return AppPath.login;
      }
      if (isAuth && isGoingLogin) {
        return AppPath.home;
      }
      return null;
    },

    routes: [
      GoRoute(
        path: AppPath.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppPath.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AppPath.home,
        builder: (context, state) => const MainScreen(),
      ),
    ],
  );
});
