import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);
    final notifier = ref.read(authProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Text("Cá nhân")),
      body: Center(
        child: Center(
          child: Column(
            children: [
              Text('Xin chào : ${state.user?.username?? 'không tìm thấy người dùng'} nhé '),
              const SizedBox(height: 20),
              IconButton(
                onPressed: () {
                  notifier.logout();
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
