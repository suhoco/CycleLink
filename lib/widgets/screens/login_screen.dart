import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> _googleLogin() async {
    final redirect = dotenv.env['REDIRECT_URL'] ?? 'http://localhost:3000/';
    await Supabase.instance.client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: dotenv.env['REDIRECT_URL'] ?? 'http://localhost:3000/',
      queryParams: {
        'prompt': 'select_account', // ← 매번 계정 선택창 표시
        // 선택: 'access_type': 'offline', 'prompt': 'consent'  // 동의창도 매번 띄우고 싶으면
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: _googleLogin,
          child: const Text('Google로 계속하기'),
        ),
      ),
    );
  }
}
