import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AcceptForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
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

  AcceptForm(
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
      padding: EdgeInsets.fromLTRB(widthButton, 15, widthButton, 15),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      backgroundColor: Colors.blue,
    );
    return Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.only(
                left: widthSize * 0.05,
                right: widthSize * 0.05,
                top: heightSize * paddingTopForm),
            child: Column(children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Câu hỏi:',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              Text('nội dung câu hỏi',
                  style: TextStyle(
                      color: Colors.white, fontSize: fontSizeTextFormField)),
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Đáp án',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              Text('nội dung Đáp án',
                  style: TextStyle(
                      color: Colors.white, fontSize: fontSizeTextFormField)),
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Câu sai 1',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              Text('nội dung câu sai 1',
                  style: TextStyle(
                      color: Colors.white, fontSize: fontSizeTextFormField)),
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Câu sai 2',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              Text('nội dung câu sai 2',
                  style: TextStyle(
                      color: Colors.white, fontSize: fontSizeTextFormField)),
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Câu sai 3',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              Text('nội dung câu sai 3',
                  style: TextStyle(
                      color: Colors.white, fontSize: fontSizeTextFormField)),
              SizedBox(height: heightSize * spaceBetweenFieldAndButton),
              Row(children: <Widget>[
                SizedBox(
                    width: 150,
                    child: TextButton(
                        style: flatButtonStyle,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {}
                        },
                        child: Text('Chấp nhận',
                            style: TextStyle(
                                fontSize: widthSize * fontSizeButton,
                                fontFamily: 'Poppins',
                                color: Colors.white)))),
                SizedBox(
                    width: 150,
                    child: TextButton(
                        style: flatButtonStyle,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {}
                        },
                        child: Text('từ chối',
                            style: TextStyle(
                                fontSize: widthSize * fontSizeButton,
                                fontFamily: 'Poppins',
                                color: Colors.white)))),
              ]),
              SizedBox(height: heightSize * 0.01),
            ])));
  }
}
