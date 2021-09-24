import 'package:flutter/material.dart';

import 'package:mtp_choice_web/screens/all_question/all_question.dart';
import 'package:mtp_choice_web/screens/all_survey/all_survey.dart';
import 'package:mtp_choice_web/screens/all_user/all_user.dart';
import 'package:mtp_choice_web/screens/notification/notification.dart';
import 'package:mtp_choice_web/screens/profile/update_screen.dart';

import '../FirstScreen.dart';

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
          Divider(
            color: Colors.white,
            thickness: 2,
          ),
          DrawerListTile(
            title: "Trang chủ",
            svgSrc: IconData(58136, fontFamily: 'MaterialIcons'),
            onPressed: () {
              Navigator.of(context).pushNamed(FirstScreen.route);
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
            title: "Phản hồi",
            svgSrc: IconData(62002, fontFamily: 'MaterialIcons'),
            onPressed: () {
              Navigator.of(context).pushNamed(NotificationScreen.route);
            },
          ),
          DrawerListTile(
            title: "Thông tin người Dùng",
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
    return Container(
      child: Column(
        children: [
          ListTile(
            onTap: onPressed,
            horizontalTitleGap: 0.0,
            hoverColor: Colors.black87,
            leading: Icon(
              svgSrc,
              color: Colors.white,
              size: 16,
            ),
            title: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Divider(
            color: Colors.white,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
