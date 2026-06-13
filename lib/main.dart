import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/core/routes/app_router.dart';

import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget { 
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { 
    
    // Gọi router ra
    final router = ref.watch(goRouterProvider); 
    return MaterialApp.router(
      title: 'Travel Planner',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router, 
    );
  }
}
