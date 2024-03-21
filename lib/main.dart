import 'package:expense_planner_app/core/theme/app_theme.dart';
import 'package:expense_planner_app/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await NotificationService.initializeNotification();
  await NotificationService.showNotification(
    title: 'ExpensePlanner',
    body: 'Add your todays expense',
    scheduled: true,
    interval: 5,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      title: 'Expense Planner App',
      home: const SplashScreen(),
    );
  }
}
