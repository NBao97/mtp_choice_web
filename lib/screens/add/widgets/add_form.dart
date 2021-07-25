import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:mtp_choice_web/models/QuestFile.dart';

class AddForm extends StatefulWidget {
  AddForm({Key? key}) : super(key: key);

  @override
  _AddFormState createState() {
    return _AddFormState(
        0, 0.01, 18, 0.08, 0.02, 0.08, 150, 0.02, 0.014, 0.02, 0.012);
  }
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  final _questionContentController = TextEditingController();
  final _difficultyController = TextEditingController();
  final _creatorController = TextEditingController();
  final _answersCorrectController = TextEditingController();
  final _answers1Controller = TextEditingController();
  final _answers2Controller = TextEditingController();
  final _answers3Controller = TextEditingController();
  Future<Question>? _futureQuestion;

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
          child: (_futureQuestion == null)
              ? buildColumn(widthSize, heightSize, flatButtonStyle)
              : buildFutureBuilder(),
        ));
  }

  Column buildColumn(
      double widthSize, double heightSize, ButtonStyle flatButtonStyle) {
    return Column(children: <Widget>[
      Align(
          alignment: Alignment.centerLeft,
          child: Text('Câu hỏi',
              style: TextStyle(
                  fontSize: widthSize * fontSizeTextField,
                  fontFamily: 'Poppins',
                  color: Colors.white))),
      TextFormField(
          maxLines: null,
          controller: _questionContentController,
          validator: (value) {
            if (value == '') {
              return 'Câu hỏi không thể để trống';
            }
          },
          cursorColor: Colors.white,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: Colors.white,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2)),
            labelStyle: TextStyle(color: Colors.white),
            errorStyle: TextStyle(
                color: Colors.white, fontSize: widthSize * errorFormMessage),
            prefixIcon: Icon(
              Icons.chat_outlined,
              size: widthSize * iconFormSize,
              color: Colors.white,
            ),
          ),
          textAlign: TextAlign.start,
          style:
              TextStyle(color: Colors.white, fontSize: fontSizeTextFormField)),
      SizedBox(height: heightSize * spaceBetweenFields),
      Align(
          alignment: Alignment.centerLeft,
          child: Text('Đáp án',
              style: TextStyle(
                  fontSize: widthSize * fontSizeTextField,
                  fontFamily: 'Poppins',
                  color: Colors.white))),
      TextFormField(
          maxLines: null,
          controller: _answersCorrectController,
          validator: (value) {
            if (value == '') {
              return 'Đáp án không thể để trống';
            }
          },
          cursorColor: Colors.white,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: Colors.white,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2)),
            labelStyle: TextStyle(color: Colors.white),
            errorStyle: TextStyle(
                color: Colors.white, fontSize: widthSize * errorFormMessage),
            prefixIcon: Icon(
              Icons.check_circle_outline,
              size: widthSize * iconFormSize,
              color: Colors.white,
            ),
          ),
          textAlign: TextAlign.start,
          style:
              TextStyle(color: Colors.white, fontSize: fontSizeTextFormField)),
      SizedBox(height: heightSize * spaceBetweenFields),
      Align(
          alignment: Alignment.centerLeft,
          child: Text('Câu sai 1',
              style: TextStyle(
                  fontSize: widthSize * fontSizeTextField,
                  fontFamily: 'Poppins',
                  color: Colors.white))),
      TextFormField(
          maxLines: null,
          controller: _answers1Controller,
          validator: (value) {
            if (value == '') {
              return 'không thể để trống câu sai';
            }
          },
          cursorColor: Colors.white,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: Colors.white,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2)),
            labelStyle: TextStyle(color: Colors.white),
            errorStyle: TextStyle(
                color: Colors.white, fontSize: widthSize * errorFormMessage),
            prefixIcon: Icon(
              Icons.clear_sharp,
              size: widthSize * iconFormSize,
              color: Colors.white,
            ),
          ),
          textAlign: TextAlign.start,
          style:
              TextStyle(color: Colors.white, fontSize: fontSizeTextFormField)),
      SizedBox(height: heightSize * spaceBetweenFields),
      Align(
          alignment: Alignment.centerLeft,
          child: Text('Câu sai 2',
              style: TextStyle(
                  fontSize: widthSize * fontSizeTextField,
                  fontFamily: 'Poppins',
                  color: Colors.white))),
      TextFormField(
          maxLines: null,
          controller: _answers2Controller,
          validator: (value) {
            if (value == '') {
              return 'không thể để trống câu sai';
            }
          },
          cursorColor: Colors.white,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: Colors.white,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2)),
            labelStyle: TextStyle(color: Colors.white),
            errorStyle: TextStyle(
                color: Colors.white, fontSize: widthSize * errorFormMessage),
            prefixIcon: Icon(
              Icons.clear_sharp,
              size: widthSize * iconFormSize,
              color: Colors.white,
            ),
          ),
          textAlign: TextAlign.start,
          style:
              TextStyle(color: Colors.white, fontSize: fontSizeTextFormField)),
      SizedBox(height: heightSize * spaceBetweenFields),
      Align(
          alignment: Alignment.centerLeft,
          child: Text('Câu sai 3',
              style: TextStyle(
                  fontSize: widthSize * fontSizeTextField,
                  fontFamily: 'Poppins',
                  color: Colors.white))),
      TextFormField(
          maxLines: null,
          controller: _answers3Controller,
          validator: (value) {
            if (value == '') {
              return 'không thể để trống câu sai';
            }
          },
          cursorColor: Colors.white,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: Colors.white,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2)),
            labelStyle: TextStyle(color: Colors.white),
            errorStyle: TextStyle(
                color: Colors.white, fontSize: widthSize * errorFormMessage),
            prefixIcon: Icon(
              Icons.clear_sharp,
              size: widthSize * iconFormSize,
              color: Colors.white,
            ),
          ),
          textAlign: TextAlign.start,
          style:
              TextStyle(color: Colors.white, fontSize: fontSizeTextFormField)),
      SizedBox(height: heightSize * spaceBetweenFields),
      Align(
          alignment: Alignment.centerLeft,
          child: Text('Độ khó',
              style: TextStyle(
                  fontSize: widthSize * fontSizeTextField,
                  fontFamily: 'Poppins',
                  color: Colors.white))),
      TextFormField(
          maxLines: null,
          controller: _difficultyController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == '') {
              return 'không thể để trống câu sai';
            }
          },
          cursorColor: Colors.white,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: Colors.white,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2)),
            labelStyle: TextStyle(color: Colors.white),
            errorStyle: TextStyle(
                color: Colors.white, fontSize: widthSize * errorFormMessage),
            prefixIcon: Icon(
              Icons.clear_sharp,
              size: widthSize * iconFormSize,
              color: Colors.white,
            ),
          ),
          textAlign: TextAlign.start,
          style:
              TextStyle(color: Colors.white, fontSize: fontSizeTextFormField)),
      SizedBox(height: heightSize * spaceBetweenFieldAndButton),
      TextButton(
          style: flatButtonStyle,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
            } else {
              createQuestion(
                  _questionContentController.text,
                  _creatorController.text,
                  _difficultyController.text,
                  _answersCorrectController.text,
                  _answers1Controller.text,
                  _answers2Controller.text,
                  _answers3Controller.text);
            }
          },
          child: Text('Thêm câu hỏi',
              style: TextStyle(
                  fontSize: widthSize * fontSizeButton,
                  fontFamily: 'Poppins',
                  color: Colors.white))),
      SizedBox(height: heightSize * 0.01),
    ]);
  }

  FutureBuilder<Question> buildFutureBuilder() {
    return FutureBuilder<Question>(
      future: _futureQuestion,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.difficulty.toString());
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }
}
