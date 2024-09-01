import 'package:dip_edge_front/app/pages/home/view/home_page.dart';
import 'package:flutter/material.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = _Paths.HOME;

  static final routes = <String, Widget Function(BuildContext)>{
    _Paths.HOME: (ctx) => HomePage(),
  };
}
