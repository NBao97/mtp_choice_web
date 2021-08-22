import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mtp_choice_web/controllers/MenuController.dart';
import 'package:mtp_choice_web/responsive.dart';
import 'package:mtp_choice_web/screens/CreateSurvey/create_survey.dart';
import 'package:mtp_choice_web/screens/add/add_question.dart';
import 'package:mtp_choice_web/screens/all_question/all_question.dart';
import 'package:mtp_choice_web/screens/all_survey/all_survey.dart';
import 'package:mtp_choice_web/screens/all_user/all_user.dart';
import 'package:mtp_choice_web/screens/login/login_page.dart';
import 'package:mtp_choice_web/screens/main/FirstScreen.dart';
import 'package:mtp_choice_web/screens/notification/notification.dart';
import 'package:mtp_choice_web/screens/profile/update_screen.dart';
import 'package:mtp_choice_web/screens/question_detail/question_detail.dart';
import 'package:mtp_choice_web/screens/survey_detail/survey_detail.dart';
import 'package:mtp_choice_web/screens/user_detail/user_detail.dart';
import 'package:provider/provider.dart';
import 'package:mtp_choice_web/constants.dart' as constant;
import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String til = 'home';
    IconData ic = IconData(58136, fontFamily: 'MaterialIcons');
    if (ModalRoute.of(context)!.settings.name == FirstScreen.route) {
      til = "Trang chủ";
      ic = IconData(58136, fontFamily: 'MaterialIcons');
    } else if (ModalRoute.of(context)!.settings.name == AllUserScreen.route) {
      til = "Trang quản lý tài khoản";
      ic = IconData(60692, fontFamily: 'MaterialIcons');
    } else if (ModalRoute.of(context)!.settings.name ==
        NotificationScreen.route) {
      til = "Trang phản hồi";
      ic = IconData(62002, fontFamily: 'MaterialIcons');
    } else if (ModalRoute.of(context)!.settings.name == UpdateScreen.route) {
      til = "Trang thông tin người dùng";
      ic = IconData(62074, fontFamily: 'MaterialIcons');
    } else if (ModalRoute.of(context)!.settings.name ==
        AllQuestionScreen.route) {
      til = "Trang quản lý câu hỏi";
      ic = IconData(62173, fontFamily: 'MaterialIcons');
    } else if (ModalRoute.of(context)!.settings.name == QuestionDetail.route) {
      til = "Nội dung câu hỏi";
      ic = IconData(62173, fontFamily: 'MaterialIcons');
    } else if (ModalRoute.of(context)!.settings.name == SurveyDetail.route) {
      til = "Kết quả khảo sát";
      ic = IconData(983246, fontFamily: 'MaterialIcons');
    } else if (ModalRoute.of(context)!.settings.name == UserDetail.route) {
      til = "Thông tin người dùng";
      ic = IconData(58520, fontFamily: 'MaterialIcons');
    } else if (ModalRoute.of(context)!.settings.name == CreateSurvey.route) {
      til = "Trang tạo khảo sát";
      ic = IconData(58617, fontFamily: 'MaterialIcons');
    } else if (ModalRoute.of(context)!.settings.name == AddQuestion.route) {
      til = "Trang tạo câu hỏi";
      ic = IconData(58619, fontFamily: 'MaterialIcons');
    } else if (ModalRoute.of(context)!.settings.name == AllSurveyScreen.route) {
      til = "Bảng khảo sát";
      ic = IconData(58617, fontFamily: 'MaterialIcons');
    }

    return Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.indigo),
            borderRadius: BorderRadius.all(Radius.circular(10.0) //
                ),
            color: constant.secondaryColor),
        child: Row(
          children: [
            if (!Responsive.isDesktop(context))
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: context.read<MenuController>().controlMenu,
              ),
            if (!Responsive.isMobile(context))
              Icon(
                ic,
                color: Colors.white54,
                size: 20,
              ),
            Text("    "),
            Text(
              til,
              style: Theme.of(context).textTheme.headline6,
            ),
            if (!Responsive.isMobile(context))
              Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
            ProfileCard()
          ],
        ));
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _signOut() async {
      await FirebaseAuth.instance
          .signOut()
          .then((value) => Get.toNamed(LoginPage.route));
    }

    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          (constant.imageU == '')
              ? Image.asset(
                  'images/profile_pic.png',
                  height: 38,
                )
              : Image.network(
                  constant.imageU,
                  height: 38,
                ),
          if (!Responsive.isMobile(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: DropdownButton<String>(
                  icon: const Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                  ),
                  iconSize: 20,
                  elevation: 16,
                  hint: Text(
                    constant.userName,
                    style: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                  items: [
                    DropdownMenuItem<String>(
                      child: Text("Đăng xuất"),
                      value: "Log out",
                    ),
                  ],
                  onChanged: (value) {
                    _signOut();
                    constant.key = constant.imageUrl = constant.id =
                        constant.userName = constant.order = constant.search =
                            constant.email = constant.questId =
                                constant.image = constant.status = '';
                    constant.form = 'text';
                    constant.log = 'log';
                    constant.page = 1;
                  }),
            ),
        ],
      ),
    );
  }
}
