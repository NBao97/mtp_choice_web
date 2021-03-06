import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtp_choice_web/controllers/MenuController.dart';
import 'package:mtp_choice_web/responsive.dart';
import 'package:mtp_choice_web/screens/CreateSurvey/widgets/survey_form.dart';
import 'package:mtp_choice_web/screens/dashboard/components/header.dart';
import 'package:mtp_choice_web/screens/main/components/side_menu.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'components/storage_details.dart';

class CreateSurvey extends StatelessWidget {
  static const String route = "/CreateSurvey";
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuController(),
        ),
      ],
      child: UpdateS(),
    );
  }
}

class UpdateS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
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
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage('images/login-bg.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "T???o kh???o s??t",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(height: defaultPadding),
                        // AddForm(0, 0.01, 18, 0.08, 0.02, 0.08, 150, 0.02, 0.014,
                        //     0.02, 0.012),
                        UpdateProfile(),

                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) StarageDetails(),
                      ],
                    ),
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
