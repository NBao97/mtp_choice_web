import 'package:mtp_choice_web/constants.dart';
import 'package:mtp_choice_web/controllers/MenuController.dart';
import 'package:mtp_choice_web/screens/login/login_page.dart';
import 'package:mtp_choice_web/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'screens/accept/accept_question.dart';
import 'screens/add/add_question.dart';
import 'screens/all_question/all_question.dart';
import 'screens/all_user/all_user.dart';
import 'screens/main/FirstScreen.dart';
import 'screens/notification/notification.dart';
import 'screens/profile/update_screen.dart';
import 'screens/question_detail/question_detail.dart';

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
        initialRoute: "/login",
        routes: {
          LoginPage.route: (context) => LoginPage(),
          FirstScreen.route: (context) => FirstScreen(),
        });
  }
}
