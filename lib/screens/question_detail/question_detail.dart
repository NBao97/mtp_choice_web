import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtp_choice_web/controllers/MenuController.dart';
import 'package:mtp_choice_web/screens/accept/accept_question.dart';
import 'package:mtp_choice_web/screens/add/add_question.dart';
import 'package:mtp_choice_web/screens/all_question/all_question.dart';
import 'package:mtp_choice_web/screens/all_user/all_user.dart';
import 'package:mtp_choice_web/screens/main/FirstScreen.dart';
import 'package:mtp_choice_web/screens/notification/notification.dart';
import 'package:mtp_choice_web/screens/profile/update_screen.dart';
import 'package:provider/provider.dart';
import 'package:mtp_choice_web/screens/main/components/side_menu.dart';
import '../../constants.dart';
import 'package:mtp_choice_web/responsive.dart';
import 'package:mtp_choice_web/screens/accept/widgets/accept_form.dart';

import 'package:mtp_choice_web/screens/accept/components/header.dart';

import 'components/storage_details.dart';


class QuestionDetail extends StatelessWidget {
  static const String route = "/QuestionDetail";
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(),
            )
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Text(
                        "Câu hỏi mới",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(height: defaultPadding),
                      // AddForm(0, 0.01, 18, 0.08, 0.02, 0.08, 150, 0.02, 0.014,
                      //     0.02, 0.012),
                      AcceptForm(0, 0.01, 18, 0.08, 0.02, 0.08, 150, 0.02,
                          0.014, 0.02, 0.012),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) StarageDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StarageDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
