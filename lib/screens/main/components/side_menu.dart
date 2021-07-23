import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mtp_choice_web/screens/accept/accept_question.dart';
import 'package:mtp_choice_web/screens/add/add_question.dart';
import 'package:mtp_choice_web/screens/all_question/all_question.dart';
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
            svgSrc: "icons/menu_dashbord.svg",
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            },
          ),
          DrawerListTile(
            title: "QuestionDetail",
            svgSrc: "icons/menu_dashbord.svg",
            onPressed: () {
              Navigator.of(context).pushNamed(QuestionDetail.route);
            },
          ),

          DrawerListTile(
            title: "Tài khoản",
            svgSrc: "icons/menu_tran.svg",
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
            title: "Thêm câu hỏi",
            svgSrc: "icons/menu_doc.svg",
            onPressed: () {
              Navigator.of(context).pushNamed(AddQuestion.route);
            },
          ),
          DrawerListTile(
            title: "Câu hỏi đóng góp",
            svgSrc: "icons/menu_store.svg",
            onPressed: () {
              Navigator.of(context).pushNamed(AcceptQuestion.route);
            },
          ),
          DrawerListTile(
            title: "Notification",
            svgSrc: "icons/menu_notification.svg",
            onPressed: () {
              Navigator.of(context).pushNamed(NotificationScreen.route);
            },
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "icons/menu_profile.svg",
            onPressed: () {
              Navigator.of(context).pushNamed(UpdateScreen.route);
            },
          ),
          DrawerListTile(
            title: "Quản lý câu hỏi",
            svgSrc: "icons/menu_setting.svg",
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

  final String title, svgSrc;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
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
