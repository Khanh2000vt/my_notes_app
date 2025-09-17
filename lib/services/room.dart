import 'package:my_notes_app/interface/room.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomService {
  late final SupabaseClient supabase;
  RoomService() {
    supabase = Supabase.instance.client;
  }

  Future<Room?> fetchRoomDetail(int roomId) async {
    final response = await supabase
        .from('rooms')
        .select('*, members(*)')
        .eq('id', roomId)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return Room.fromJson(response);
  }
}
