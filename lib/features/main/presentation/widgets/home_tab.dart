import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/routes/app_path.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_provider.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lắng nghe trạng thái đăng nhập để tự động quay lại Login khi bấm Đăng xuất
    ref.listen<AsyncValue>(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (user) {
          if (user == null) {
            // Nếu trạng thái user về null, quay về trang Login
            context.go(AppPath.login);
          }
        },
      );
    });

    final userState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách chuyến đi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Gọi hàm logout của Riverpod để đăng xuất
              ref.read(authNotifierProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: Row(
        children: [
          Center(
            child: userState.when(
              data: (user) => Text('Chào mừng, ${user?.name ?? "Khách"}!'),
              loading: () => const CircularProgressIndicator(),
              error: (err, stack) => Text('Lỗi: $err'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Gọi hàm logout của Riverpod để đăng xuất
              ref.read(authNotifierProvider.notifier).logout();
            },
          ),
        ],
      ),
    );
  }
}
