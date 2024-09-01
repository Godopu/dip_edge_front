import 'package:dip_edge_front/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  final ValueNotifier<int> selectedIndex;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SideMenu({
    super.key,
    required this.scaffoldKey,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      child: ListView(
        children: [
          DrawerHeader(child: SvgPicture.asset(APP_LOGO)),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: MENU_DASHBOARD,
            press: () {
              selectedIndex.value = 0;
              if (scaffoldKey.currentState!.isDrawerOpen) {
                Future.delayed(const Duration(milliseconds: 100), () {
                  Navigator.pop(context);
                });
              }
            },
            color: selectedIndex.value == 0 ? Colors.white : Colors.white54,
          ),
          DrawerListTile(
            title: "Logs",
            svgSrc: MENU_TRAN,
            press: () {
              selectedIndex.value = 1;
              if (scaffoldKey.currentState!.isDrawerOpen) {
                Future.delayed(const Duration(milliseconds: 100), () {
                  Navigator.pop(context);
                });
              }
            },
            color: selectedIndex.value == 1 ? Colors.white : Colors.white54,
          )
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.color,
  });

  final String title, svgSrc;
  final VoidCallback press;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: color),
      ),
    );
  }
}
