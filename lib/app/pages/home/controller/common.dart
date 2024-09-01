import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

SupabaseClient supabase = Supabase.instance.client
  ..auth.signInWithPassword(
    email: "godopu16@godopu.net",
    password: "Rhehvn16^^",
  );

class HomeConfiguration {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
}
