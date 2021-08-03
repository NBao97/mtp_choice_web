import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mtp_choice_web/screens/CreateSurvey/create_survey.dart';
import 'package:mtp_choice_web/screens/add/add_question.dart';
import 'package:mtp_choice_web/screens/all_question/all_question.dart';
import 'package:mtp_choice_web/screens/all_survey/all_survey.dart';
import 'package:mtp_choice_web/screens/all_user/all_user.dart';
import 'package:mtp_choice_web/screens/notification/notification.dart';
import 'package:mtp_choice_web/screens/profile/update_screen.dart';
import 'package:mtp_choice_web/screens/question_detail/question_detail.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset('images/mtp_logo.png'),
          ),
          DrawerListTile(
            title: "Home",
            svgSrc: IconData(58136, fontFamily: 'MaterialIcons'),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            },
          ),

          DrawerListTile(
            title: "Quản lý Tài khoản",
            svgSrc: IconData(60692, fontFamily: 'MaterialIcons'),
            onPressed: () {
              Navigator.of(context).pushNamed(AllUserScreen.route);
            },
          ),
          // DrawerListTile(
          //   title: "Task",
          //   svgSrc: "icons/menu_task.svg",
          //   onPressed: () {},
          // ),

          DrawerListTile(
            title: "Quản lý khảo sát",
            svgSrc: IconData(62173, fontFamily: 'MaterialIcons'),
            onPressed: () {
              Navigator.of(context).pushNamed(AllSurveyScreen.route);
            },
          ),
          DrawerListTile(
            title: "Notification",
            svgSrc: IconData(62002, fontFamily: 'MaterialIcons'),
            onPressed: () {
              Navigator.of(context).pushNamed(NotificationScreen.route);
            },
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: IconData(62074, fontFamily: 'MaterialIcons'),
            onPressed: () {
              Navigator.of(context).pushNamed(UpdateScreen.route);
            },
          ),
          DrawerListTile(
            title: "Quản lý câu hỏi",
            svgSrc: IconData(60990, fontFamily: 'MaterialIcons'),
            onPressed: () {
              Navigator.of(context).pushNamed(AllQuestionScreen.route);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once onPressed "Command+D"
    required this.title,
    required this.svgSrc,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final IconData svgSrc;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      horizontalTitleGap: 0.0,
      leading: Icon(
        svgSrc,
        color: Colors.white54,
        size: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
