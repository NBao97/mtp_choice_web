import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtp_choice_web/controllers/MenuController.dart';
import 'package:mtp_choice_web/screens/accept/accept_question.dart';
import 'package:mtp_choice_web/screens/add/add_question.dart';
import 'package:mtp_choice_web/screens/all_question/all_question.dart';
import 'package:mtp_choice_web/screens/all_user/all_user.dart';
import 'package:mtp_choice_web/screens/notification/notification.dart';
import 'package:mtp_choice_web/screens/profile/update_screen.dart';
import 'package:mtp_choice_web/screens/question_detail/question_detail.dart';
import 'package:mtp_choice_web/screens/user_detail/user_detail.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'main_screen.dart';

class FirstScreen extends StatelessWidget {
  static const String route = "/home";
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      initialRoute: "/",
      routes: {
        QuestionDetail.route: (context) => QuestionDetail(),
        AllUserScreen.route: (context) => AllUserScreen(),
        AddQuestion.route: (context) => AddQuestion(),
        AcceptQuestion.route: (context) => AcceptQuestion(),
        NotificationScreen.route: (context) => NotificationScreen(),
        UpdateScreen.route: (context) => UpdateScreen(),
        AllQuestionScreen.route: (context) => AllQuestionScreen(),
        UserDetail.route: (context) => UserDetail(),
      },
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
        ],
        child: MainScreen(),
      ),
    );
  }
}
