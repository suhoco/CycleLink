import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final _sb = Supabase.instance.client;

  String get uid => _sb.auth.currentUser!.id;

  Future<Map<String, dynamic>?> getMyProfile() async {
    return await _sb.from('profiles').select().eq('id', uid).maybeSingle();
  }

  Future<void> updateMyProfile({
    String? nickname,
    String? location,
    String? avatarUrl,
  }) async {
    await _sb.from('profiles').update({
      if (nickname != null) 'nickname': nickname,
      if (location != null) 'location': location,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
    }).eq('id', uid);
  }
}
