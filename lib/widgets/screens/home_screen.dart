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
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut(); // ← 이것만
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('로그아웃 되었습니다')),
              );
              // Navigator.pop() 같은 추가 네비게이션은 하지 마세요.
            },
          ),
        ],
      ),
      body: const Center(child: Text("Hello, CycleLink!")),
    );
  }
}
