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
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.user == null && previous?.user != null) {
        // Nếu trạng thái user về null, quay về trang Login
        context.go(AppPath.login);
      }
    });

    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách chuyến đi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Gọi hàm logout của Riverpod để đăng xuất
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: Row(
        children: [
          Center(
            child: authState.isLoading
                ? const CircularProgressIndicator()
                : authState.errorMessage != null
                    ? Text('Lỗi: ${authState.errorMessage}')
                    : Text('Chào mừng, ${authState.user?.fullName ?? "Khách"}!'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Gọi hàm logout của Riverpod để đăng xuất
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
    );
  }
}
