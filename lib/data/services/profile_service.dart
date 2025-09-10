import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final _sb = Supabase.instance.client;

  Future<Map<String, dynamic>?> getMyProfile() async {
    final uid = _sb.auth.currentUser!.id;
    final res = await _sb.from('profiles').select().eq('id', uid).maybeSingle();
    return res;
  }

  Future<void> updateMyProfile({
    String? nickname,
    String? location,
    String? avatarUrl,
  }) async {
    final uid = _sb.auth.currentUser!.id;
    await _sb.from('profiles').update({
      if (nickname != null) 'nickname': nickname,
      if (location != null) 'location': location,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
    }).eq('id', uid);
  }
}
