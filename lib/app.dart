import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'widgets/screens/splash/splash_screen.dart';

class BikeMarketApp extends StatelessWidget {
  const BikeMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BikeMarket',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}