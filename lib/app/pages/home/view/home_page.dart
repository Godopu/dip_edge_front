import 'package:dip_edge_front/app/common/responsive.dart';
import 'package:dip_edge_front/app/pages/home/controller/common.dart';
import 'package:dip_edge_front/app/pages/home/view/dashboard_panel.dart';
import 'package:dip_edge_front/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'side_menu.dart';

class HomePage extends HookConsumerWidget {
  HomePage({super.key});

  final conf = HomeConfiguration();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);
    return SafeArea(
      child: Scaffold(
        key: conf.scaffoldKey,
        // drawer: Drawer(),
        drawer: SideMenu(
          // sele
          selectedIndex: selectedIndex,
          scaffoldKey: conf.scaffoldKey,
        ),
        appBar: Responsive.isMobile(context)
            ? PreferredSize(
                preferredSize: const Size(60, 60),
                child: AppBar(
                  toolbarHeight: 60,
                  elevation: 0,
                  backgroundColor: bgColor,
                  leading: IconButton(
                    onPressed: () {
                      conf.scaffoldKey.currentState!.openDrawer();
                    },
                    icon: const Icon(Icons.menu, color: Colors.white),
                  ),
                  title: Text(
                    "ETRI Smart Farm",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[100],
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              )
            : null,
        body: Row(
          children: [
            if (!Responsive.isMobile(context))
              SideMenu(
                scaffoldKey: conf.scaffoldKey,
                selectedIndex: selectedIndex,
              ),
            Expanded(
              child: IndexedStack(
                index: selectedIndex.value,
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: selectedIndex.value == 0 ? 1 : 0,
                    child: const SizedBox.expand(child: DashboardPanel()),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 200,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                    ),
                    child: const Text('Home Page'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
