import 'package:flutter/material.dart';
import 'package:mtp_choice_web/screens/login/widgets/login_form.dart';

class DesktopMode extends StatefulWidget {
  @override
  _DesktopModeState createState() => _DesktopModeState();
}

class _DesktopModeState extends State<DesktopMode> {
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;

    return Container(
        color: Color.fromRGBO(191, 0, 255, 1),
        child: Center(
            child: Container(
                height: heightSize * 0.8,
                width: widthSize * 0.8,
                child: Card(
                    elevation: 5,
                    child: Row(children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                              child: Align(
                            alignment: Alignment.center,
                            child: Image.asset('images/login-image.png',
                                height: heightSize * 0.5,
                                width: widthSize * 0.5,
                                semanticLabel: 'test'),
                          ))),
                      Expanded(
                          flex: 1,
                          child: Container(
                              padding: EdgeInsets.only(top: 20),
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  image: new AssetImage('images/login-bg.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: SingleChildScrollView(
                                  reverse: true,
                                  padding: EdgeInsets.all(32),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset('images/mtp_logo.png',
                                            height: heightSize * 0.2,
                                            width: widthSize * 0.15),
                                        SizedBox(height: 20),
                                        LoginForm(0, 0.009, 16, 0.04, 0.01,
                                            0.04, 75, 0.01, 0.007, 0.01, 0.006)
                                      ]))))
                    ])))));
  }
}
