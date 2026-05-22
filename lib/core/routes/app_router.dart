import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/routes/app_path.dart';
import 'package:travel_planner/features/auth/presentation/pages/login_page.dart';
import 'package:travel_planner/features/auth/presentation/pages/onboarding_page.dart';
import 'package:travel_planner/features/auth/presentation/pages/register_page.dart';
import 'package:travel_planner/features/auth/presentation/pages/splash_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppPath.splash,
    debugLogDiagnostics: true,

    routes: [
      GoRoute(path: AppPath.splash, builder: (context, state) => SplashPage()),
      GoRoute(
        path: AppPath.onboarding,
        builder: (context, state) => OnboardingPage(),
      ),
      GoRoute(
        path: AppPath.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppPath.register,
        builder: (context, state) => const RegisterPage(),
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text("Khong tim thay trang: ${state.uri}")),
    ),
  );
}
