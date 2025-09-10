import 'package:flutter/material.dart';
import '../../../data/services/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _svc = ProfileService();
  final _nick = TextEditingController();
  final _loc = TextEditingController();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = await _svc.getMyProfile();
    _nick.text = p?['nickname'] ?? '';
    _loc.text = p?['location'] ?? '';
    setState(() => _loading = false);
  }

  Future<void> _save() async {
    await _svc.updateMyProfile(
      nickname: _nick.text.trim(),
      location: _loc.text.trim(),
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('저장되었습니다')),
    );
  }

  @override
  void dispose() {
    _nick.dispose();
    _loc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: const Text('마이페이지')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nick, decoration: const InputDecoration(labelText: '닉네임')),
            const SizedBox(height: 12),
            TextField(controller: _loc, decoration: const InputDecoration(labelText: '활동 지역')),
            const SizedBox(height: 24),
            FilledButton(onPressed: _save, child: const Text('저장')),
          ],
        ),
      ),
    );
  }
}
