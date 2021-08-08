import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtp_choice_web/screens/CreateSurvey/create_survey.dart';
import 'package:mtp_choice_web/screens/accept/accept_question.dart';
import 'package:mtp_choice_web/screens/add/add_question.dart';
import 'package:mtp_choice_web/screens/all_question/all_question.dart';
import 'package:mtp_choice_web/screens/all_survey/all_survey.dart';
import 'package:mtp_choice_web/screens/all_user/all_user.dart';
import 'package:mtp_choice_web/screens/login/login_page.dart';
import 'package:mtp_choice_web/screens/notification/notification.dart';
import 'package:mtp_choice_web/screens/profile/update_screen.dart';
import 'package:mtp_choice_web/screens/question_detail/question_detail.dart';
import 'package:mtp_choice_web/screens/survey_detail/survey_detail.dart';
import 'package:mtp_choice_web/screens/user_detail/user_detail.dart';
import 'package:get/get.dart';
import 'constants.dart';
import 'screens/main/FirstScreen.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:mtp_choice_web/constants.dart' as constant;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
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
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        title: 'flutter web login ui',
        initialRoute: "/login",
        navigatorKey: Get.key,
        routes: {
          LoginPage.route: (context) => LoginPage(),
          FirstScreen.route: (context) => FirstScreen(),
          QuestionDetail.route: (context) => QuestionDetail(),
          AllUserScreen.route: (context) => AllUserScreen(),
          AddQuestion.route: (context) => AddQuestion(),
          AcceptQuestion.route: (context) => AcceptQuestion(),
          NotificationScreen.route: (context) => NotificationScreen(),
          UpdateScreen.route: (context) => UpdateScreen(),
          AllQuestionScreen.route: (context) => AllQuestionScreen(),
          UserDetail.route: (context) => UserDetail(),
          AllSurveyScreen.route: (context) => AllSurveyScreen(),
          SurveyDetail.route: (context) => SurveyDetail(),
          CreateSurvey.route: (context) => CreateSurvey(),
        });
  }
}
