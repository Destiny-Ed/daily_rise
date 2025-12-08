import 'package:daily_rise/core/constant.dart';
import 'package:daily_rise/core/theme.dart';
import 'package:daily_rise/injection.dart';
import 'package:daily_rise/presentation/views/auth/social_auth.dart';
import 'package:daily_rise/service/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();

  // NotificationService().init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers(context),
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: const SocialAuthScreen(),
      ),
    );
  }
}
