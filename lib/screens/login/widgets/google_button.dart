import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/controllers/GoogleLogin.dart';

import 'package:mtp_choice_web/screens/main/FirstScreen.dart';
import 'package:mtp_choice_web/constants.dart' as constant;

class GoogleButton extends StatefulWidget {
  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  bool _isProcessing = false;
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    backgroundColor: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.white24, width: 2),
        ),
        color: Colors.white,
      ),
      child: TextButton(
        style: flatButtonStyle,
        onPressed: () async {
          setState(() {
            _isProcessing = true;
          });
          await signInWithGoogle().then((result) async {
            if (result != "") {
              await login(result.toString()).then((value) async {
                if (value.contains("Success")) {
                  Get.toNamed(FirstScreen.route);
                } else if (value.contains("Permiss")) {
                  Get.snackbar(
                      'Thông báo', 'Bạn không có quyền truy cập trang này',
                      duration: Duration(seconds: 4),
                      animationDuration: Duration(milliseconds: 800),
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.white);
                  constant.key = constant.imageUrl = constant.id =
                      constant.userName = constant.order = constant.search =
                          constant.email = constant.questId =
                              constant.image = constant.status = '';
                } else {
                  Get.snackbar('Thông báo', 'Tài khoản chưa được đăng ký',
                      duration: Duration(seconds: 4),
                      animationDuration: Duration(milliseconds: 800),
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.white);
                }
              });
            }
          }).catchError((error) {
            print('Registration Error: $error');
          });
          setState(() {
            _isProcessing = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: _isProcessing
              ? CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Colors.blueGrey,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image(
                      image: AssetImage("images/google_logo.png"),
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Text(
                        'Login with Google',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.01,
                          color: Colors.blueGrey,
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
