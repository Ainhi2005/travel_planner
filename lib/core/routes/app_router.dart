import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/routes/app_path.dart';
import 'package:travel_planner/features/auth/presentation/pages/login_page.dart';
import 'package:travel_planner/features/auth/presentation/pages/register_page.dart';
import 'package:travel_planner/features/main/presentation/pages/main_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppPath.login,
    debugLogDiagnostics: true,

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
        builder: (context, state) => const MainPage(),
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text("Khong tim thay trang: ${state.uri}")),
    ),
  );
}
