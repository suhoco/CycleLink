import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'widgets/auth/auth_gate.dart';

class CycleLinkApp extends StatelessWidget {
  const CycleLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CycleLink',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: AuthGate(), // const 빼서 컴파일러 const 요구 피함
    );
  }
}
