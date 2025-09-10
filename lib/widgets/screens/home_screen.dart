import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'profile_screen.dart'; // 아래 2번에서 만들 파일

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CycleLink"),
        actions: [
          IconButton(
            tooltip: '마이페이지',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            tooltip: '로그아웃',
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              // signOut 후엔 AuthGate에서 로그인 화면으로 바뀜
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('로그아웃 되었습니다')),
                );
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(child: Text("Hello, CycleLink!")),
    );
  }
}
