import 'package:flutter/material.dart';

import 'desktop_mode.dart';

class LoginPage extends StatefulWidget {
  static const String route = "/login";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DesktopMode();
        // }
      },
    );
  }
}
