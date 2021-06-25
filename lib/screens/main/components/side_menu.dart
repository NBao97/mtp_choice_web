import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mtp_choice_web/screens/accept/accept_question.dart';
import 'package:mtp_choice_web/screens/add/add_question.dart';
import 'package:mtp_choice_web/screens/all_question/all_question.dart';
import 'package:mtp_choice_web/screens/all_user/all_user.dart';
import 'package:mtp_choice_web/screens/notification/notification.dart';
import 'package:mtp_choice_web/screens/main/FirstScreen.dart';
import 'package:mtp_choice_web/screens/profile/update_screen.dart';

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
            svgSrc: "icons/menu_dashbord.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FirstScreen()),
              );
            },
          ),
          DrawerListTile(
            title: "Tài khoản",
            svgSrc: "icons/menu_tran.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllUserScreen()),
              );
            },
          ),
          // DrawerListTile(
          //   title: "Task",
          //   svgSrc: "icons/menu_task.svg",
          //   press: () {},
          // ),
          DrawerListTile(
            title: "Thêm câu hỏi",
            svgSrc: "icons/menu_doc.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddQuestion()),
              );
            },
          ),
          DrawerListTile(
            title: "Câu hỏi đóng góp",
            svgSrc: "icons/menu_store.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AcceptQuestion()),
              );
            },
          ),
          DrawerListTile(
            title: "Notification",
            svgSrc: "icons/menu_notification.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "icons/menu_profile.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateScreen()),
              );
            },
          ),
          DrawerListTile(
            title: "Quản lý câu hỏi",
            svgSrc: "icons/menu_setting.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllQuestionScreen()),
              );
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
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
