import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_provider.dart';

import '../../../../core/theme/app_colors.dart';

class HomeHeader extends ConsumerWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: user?.avatarUrl!=null
          ? NetworkImage(user!.avatarUrl!) 
          : AssetImage('assets/images/logo.jpg'),
          radius: 20,
        ),
        SizedBox(width: 10),
        Text(
          'Traver Planner',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("chuyển đến trang thông báo")),
            );
          },
          icon: Icon(Icons.notifications_outlined, size: 30, weight: 20),
        ),
      ],
    );
  }
}
