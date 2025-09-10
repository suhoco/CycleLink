import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Supabase.instance.client.auth;

    return StreamBuilder<AuthState>(
      stream: auth.onAuthStateChange,                   // ← 상태변화 구독
      builder: (context, snapshot) {
        // 로딩/초기화 순간엔 스플래시(깜빡임 방지)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        // 스트림의 최신 세션이 우선, 없으면 현재 세션
        final session = snapshot.data?.session ?? auth.currentSession;

        if (session == null) {
          return const LoginScreen();                   // 로그아웃 즉시 여기로
        }
        return const HomeScreen();
      },
    );
  }
}
