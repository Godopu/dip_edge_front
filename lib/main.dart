import 'package:dip_edge_front/app/routes/app_pages.dart';
import 'package:dip_edge_front/const.dart';
import 'package:dip_edge_front/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'colors.dart';

void main() async {
  try {
    await Supabase.initialize(
      url: 'https://supabase.godopu.com',
      anonKey: SUPABASE_ANONKEY,
    );
  } catch (e) {
    printLog(e);
    return;
  }

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DIP Intelligent NVR',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        canvasColor: secondaryColor,
      ),
      routes: AppPages.routes,
      initialRoute: Routes.HOME,
    );
  }
}
