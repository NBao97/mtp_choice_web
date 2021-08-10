import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/controllers/VideoController.dart';
import 'package:mtp_choice_web/models/RecentFile.dart';
import 'dart:async';
import '../../../constants.dart' as constant;
import 'package:mtp_choice_web/models/QuestFile.dart';
import 'package:video_player/video_player.dart';

class AddForm extends StatefulWidget {
  AddForm({Key? key}) : super(key: key);

  @override
  _AddFormState createState() {
    return _AddFormState(
        0, 0.01, 18, 0.08, 0.02, 0.08, 150, 0.02, 0.014, 0.02, 0.012);
  }
}

int _value = 0;
List answerId = [];
List answerContent = [];
String ques = '';

class _AddFormState extends State<AddForm> {
  Future<List<QuestionFile>>? _futureQuestion;
  final String qus = constant.questId;
  @override
  void initState() {
    super.initState();
    _futureQuestion = fetchQuestion(constant.page, constant.order, qus);
  }

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
    GlobalKey<FormState> _formAdf =
        new GlobalKey<FormState>(debugLabel: '_updateFormState');

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
    return FutureBuilder<List<QuestionFile>>(
        future: _futureQuestion,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final QuestionFile quest = snapshot.data!.single;
            constant.status = quest.status!;

            final _questionContentController =
                TextEditingController(text: quest.questionContent);
            // final _difficultyController = TextEditingController(text: "0");
            final _answersCorrectController = TextEditingController();

            for (Answers an in quest.ans!) {
              if (an.isCorrect == true) {
                _answersCorrectController.text = an.answerContent!;

                answerId.insert(0, an.answerId);
                answerContent.insert(0, an.answerContent);
              } else {
                answerId.add(an.answerId);
                answerContent.add(an.answerContent);
              }
            }
            print('it is answer' + _answersCorrectController.text);

            final _answers1Controller =
                TextEditingController(text: answerContent[1]);
            final _answers2Controller =
                TextEditingController(text: answerContent[2]);
            final _answers3Controller =
                TextEditingController(text: answerContent[3]);

            return Form(
                key: _formAdf,
                child: Padding(
                    padding: EdgeInsets.only(
                        left: widthSize * 0.05,
                        right: widthSize * 0.05,
                        top: heightSize * paddingTopForm),
                    child: Column(children: <Widget>[
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
                          onChanged: (value) {
                            ques = value;
                          },
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
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * errorFormMessage),
                            prefixIcon: Icon(
                              Icons.chat_outlined,
                              size: widthSize * iconFormSize,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      if (quest.imageUrl != null)
                        SizedBox(
                          height: 300,
                          width: 400,
                          child: Image.network(quest.imageUrl!),
                        ),
                      if (quest.videoUrl != null)
                        VideoItems(
                          videoPlayerController:
                              VideoPlayerController.network(quest.videoUrl!),
                        ),
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
                          onChanged: (value) {
                            answerContent[0] = value;
                          },
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
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * errorFormMessage),
                            prefixIcon: Icon(
                              Icons.check_circle_outline,
                              size: widthSize * iconFormSize,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      VideoItems(
                        videoPlayerController: VideoPlayerController.network(
                            "https://firebasestorage.googleapis.com/v0/b/mcqfb-56f80.appspot.com/o/avatar%2F28b77b90-f92d-11eb-9173-5996192c2a36?alt=media&token=193a3e46-0566-4413-99af-07ee59d5e88a"),
                      ),
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
                          onChanged: (value) {
                            answerContent[1] = value;
                          },
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
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * errorFormMessage),
                            prefixIcon: Icon(
                              Icons.clear_sharp,
                              size: widthSize * iconFormSize,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
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
                          onChanged: (value) {
                            answerContent[2] = value;
                          },
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
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * errorFormMessage),
                            prefixIcon: Icon(
                              Icons.clear_sharp,
                              size: widthSize * iconFormSize,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
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
                          onChanged: (value) {
                            answerContent[3] = value;
                          },
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
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * errorFormMessage),
                            prefixIcon: Icon(
                              Icons.clear_sharp,
                              size: widthSize * iconFormSize,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Độ khó',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      DropdownButton(
                          value: _value,
                          items: [
                            DropdownMenuItem(
                              child: Text("Dễ"),
                              value: 0,
                            ),
                            DropdownMenuItem(
                              child: Text("Trung Bình"),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text("Khó"),
                              value: 2,
                            )
                          ],
                          onChanged: (value) {
                            setState(() {
                              _value = int.parse(value.toString());
                              if (ques != '') {
                                _questionContentController.text = ques;
                              }
                              _answersCorrectController.text = answerContent[0];
                              _answers1Controller.text = answerContent[1];
                              _answers1Controller.text = answerContent[1];
                              _answers2Controller.text = answerContent[2];
                              _answers3Controller.text = answerContent[3];
                            });
                          },
                          hint: Text("Select item")),
                      SizedBox(height: heightSize * spaceBetweenFieldAndButton),
                      TextButton(
                          style: flatButtonStyle,
                          onPressed: () async {
                            answerContent.clear();
                            answerContent = [
                              _answersCorrectController.text,
                              _answers1Controller.text,
                              _answers2Controller.text,
                              _answers3Controller.text
                            ];
                            if (_formAdf.currentState!.validate()) {
                              updateQuestion(
                                      quest.questionId!,
                                      _questionContentController.text,
                                      _value,
                                      answerId,
                                      answerContent)
                                  .catchError((error) {
                                Get.snackbar('Thông báo', 'Nhập thất bại',
                                    duration: Duration(seconds: 4),
                                    animationDuration:
                                        Duration(milliseconds: 800),
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: Colors.white);
                              });
                            }
                          },
                          child: Text('Thêm câu hỏi',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeButton,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      SizedBox(height: heightSize * 0.01),
                    ])));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        });
  }
}
