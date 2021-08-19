import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mtp_choice_web/controllers/MenuController.dart';
import 'package:mtp_choice_web/responsive.dart';
import 'package:mtp_choice_web/screens/login/login_page.dart';
import 'package:provider/provider.dart';
import 'package:mtp_choice_web/constants.dart' as constant;
import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                IconData(58136, fontFamily: 'MaterialIcons'),
                color: Colors.white54,
                size: 20,
              ),
            Text("    "),
            Text(
              "Home",
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
          Image.asset(
            'images/profile_pic.png',
            height: 38,
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: DropdownButton<String>(
                  icon: const Icon(Icons.arrow_downward),
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
