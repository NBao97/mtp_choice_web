import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mtp_choice_web/controllers/MenuController.dart';
import 'package:mtp_choice_web/screens/dashboard/dashboard_screen.dart';

import 'package:provider/provider.dart';

import '../../responsive.dart';
import 'components/side_menu.dart';

class FirstScreen extends StatelessWidget {
  static const String route = "/first";
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuController(),
        ),
      ],
      child: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
