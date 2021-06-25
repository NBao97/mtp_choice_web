import 'package:mtp_choice_web/constants.dart';
import 'package:mtp_choice_web/controllers/MenuController.dart';
import 'package:mtp_choice_web/screens/login/login_page.dart';
import 'package:mtp_choice_web/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'flutter web login ui',
        initialRoute: '/login',
        routes: {'/login': (context) => LoginPage()});
  }
}
