import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtp_choice_web/models/UserFile.dart';
import '../../../constants.dart' as constant;

class AcceptForm extends StatefulWidget {
  AcceptForm({Key? key}) : super(key: key);

  @override
  _AddFormState createState() {
    return _AddFormState(
        0, 0.01, 18, 0.08, 0.02, 0.08, 150, 0.02, 0.014, 0.02, 0.012);
  }
}

class _AddFormState extends State<AcceptForm> {
  late Future<List<Users>> futureData;
  String qus = constant.questId;

  @override
  void initState() {
    super.initState();
    futureData = fetchUserAll(qus);
  }

  // final GlobalKey<FormState> _formSur =
  //     new GlobalKey<FormState>(debugLabel: '_UpuserFormState');
  // final _usernameController = TextEditingController();

  final paddingTopForm,
      fontSizeTextField,
      fontSizeTextFormField,
      spaceBetweenFields,
      iconFormSize;
  final spaceBetweenFieldAndButton,
      widthButton,
      fontSizeButton,
      fontSizeForgotPassword,
      fontSizeSnackBar,
      errorFormMessage;

  _AddFormState(
      this.paddingTopForm,
      this.fontSizeTextField,
      this.fontSizeTextFormField,
      this.spaceBetweenFields,
      this.iconFormSize,
      this.spaceBetweenFieldAndButton,
      this.widthButton,
      this.fontSizeButton,
      this.fontSizeForgotPassword,
      this.fontSizeSnackBar,
      this.errorFormMessage);

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      backgroundColor: Colors.blue,
    );
    return FutureBuilder<List<Users>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Users quest = snapshot.data!.single;

            // constant.status = quest.userStatus!;
            return Form(
                // key: _formSur,
                child: Padding(
                    padding: EdgeInsets.only(
                        left: widthSize * 0.05,
                        right: widthSize * 0.05,
                        top: heightSize * paddingTopForm),
                    child: Column(children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('User ID:',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      Text(quest.userId!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Email',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      Text(quest.email!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('phone',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      Text((quest.phone == null) ? "" : quest.phone!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Họ và tên',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      Text(quest.fullname == null ? '' : quest.fullname!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Điểm thưởng',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      Text(quest.bonusPoint!.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFieldAndButton),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Vai trò',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      Text(
                          (quest.userRole == 'ADMIN')
                              ? 'Quản lý'
                              : 'Người Dùng',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFieldAndButton),
                      if (quest.his!.isNotEmpty)
                        for (Histories hi in quest.his!)
                          Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('điểm',
                                        style: TextStyle(
                                            fontSize:
                                                widthSize * fontSizeTextField,
                                            fontFamily: 'Poppins',
                                            color: Colors.white))),
                                Text(hi.score.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSizeTextFormField)),
                                SizedBox(
                                    height: heightSize * spaceBetweenFields),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('thời gian hoàn thành',
                                        style: TextStyle(
                                            fontSize:
                                                widthSize * fontSizeTextField,
                                            fontFamily: 'Poppins',
                                            color: Colors.white))),
                                Text(hi.timeFinished!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSizeTextFormField)),
                                SizedBox(
                                    height: heightSize * spaceBetweenFields),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Tên game',
                                        style: TextStyle(
                                            fontSize:
                                                widthSize * fontSizeTextField,
                                            fontFamily: 'Poppins',
                                            color: Colors.white))),
                                Text(hi.game!.gameDescription!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSizeTextFormField)),
                                SizedBox(
                                    height:
                                        heightSize * spaceBetweenFieldAndButton)
                              ]))
                      // TextButton(
                      //     style: flatButtonStyle,
                      //     onPressed: () async {
                      //       if (_formSur.currentState!.validate()) {}
                      //     },
                      //     child: Text('reset password',
                      //         style: TextStyle(
                      //             fontSize: widthSize * fontSizeButton,
                      //             fontFamily: 'Poppins',
                      //             color: Colors.white))),
                      // SizedBox(height: heightSize * 0.01),
                    ])));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        });
  }
}
