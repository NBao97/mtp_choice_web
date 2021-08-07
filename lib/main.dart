import 'package:flutter/material.dart';
import 'package:mtp_choice_web/screens/login/login_page.dart';

import 'screens/main/FirstScreen.dart';

void main() {
  runApp(MyApp());
}

//flutter run -d chrome --web-hostname localhost --web-port
//  8080
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'flutter web login ui',
        initialRoute: "/login",
        routes: {
          LoginPage.route: (context) => LoginPage(),
          FirstScreen.route: (context) => FirstScreen(),
        });
  }
}
