import 'package:supabase_flutter/supabase_flutter.dart';

class LoginService {
  late final SupabaseClient supabase;

  LoginService() {
    supabase = Supabase.instance.client;
  }

  Future<int?> checkUserOtp(String username, String otp) async {
    final supabase = Supabase.instance.client;

    final response = await supabase
        .from('users')
        .select('id')
        .eq('username', username)
        .eq('otp', otp)
        .maybeSingle();

    print('response: $response');

    if (response == null) return null;
    return response['id'] as int;
  }
}
