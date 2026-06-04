import 'package:travel_planner/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final nguoidung = authState.user;
    return Scaffold(
      appBar: AppBar(
        title: Text('trangchu'),
        backgroundColor: Colors.blueAccent,),
        body: Center(
          child: Text('${nguoidung?.username}'),
        ),
    );
  }
}
