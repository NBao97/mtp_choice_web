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

List answerId = [];
List answerContent = [];
String ques = '';
int check = 0;

class _AddFormState extends State<AddForm> {
  GlobalKey<FormState> _formAdf =
      new GlobalKey<FormState>(debugLabel: '_updateFormState');
  Future<List<QuestionFile>>? _futureQuestion;
  final String qus = constant.questId;
  int _value = 0;
  @override
  void initState() {
    super.initState();
    answerContent.clear();
    answerId.clear();
    ques = '';
    _value = 0;
    check = 0;
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
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    String image = '';
    String video = '';
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
            if (check == 0) {
              if (quest.difficulty != null) _value = quest.difficulty!;
            }

            final _questionContentController =
                TextEditingController(text: quest.questionContent);
            // final _difficultyController = TextEditingController(text: "0");
            final _answersCorrectController = TextEditingController();
            final _descriptController =
                TextEditingController(text: quest.questionDescription);

            if (answerContent.isEmpty == true && check == 0) {
              for (Answers an in quest.ans!) {
                if (an.isCorrect == true) {
                  check++;
                  _answersCorrectController.text = an.answerContent!;

                  answerId.insert(0, an.answerId);
                  answerContent.insert(0, an.answerContent);
                } else {
                  check++;
                  answerId.add(an.answerId);
                  answerContent.add(an.answerContent);
                }
              }
              print(answerContent);
            } else {
              _answersCorrectController.text = answerContent[0];
            }
            if (quest.status == "KHAO_SAT_QUESTION") {
              _answersCorrectController.text = answerContent[0];
            }
            final _answers1Controller = TextEditingController(
                text: answerContent.isEmpty ? '' : answerContent[1]);

            final _answers2Controller = TextEditingController(
                text: answerContent.isEmpty ? '' : answerContent[2]);
            final _answers3Controller = TextEditingController(
                text: answerContent.isEmpty ? '' : answerContent[3]);
            if (quest.videoUrl != null) {
              if (quest.videoUrl != '') {
                video = quest.videoUrl!;
              }
            }
            if (quest.imageUrl != null) {
              if (quest.imageUrl != '') {
                image = quest.imageUrl!;
              }
            }

            return Form(
                key: _formAdf,
                child: Padding(
                    padding: EdgeInsets.only(
                        left: widthSize * 0.05,
                        right: widthSize * 0.05,
                        top: heightSize * paddingTopForm),
                    child: Column(children: <Widget>[
                      Text("Tác giả " +
                          (quest.creatorUserId == ""
                              ? " "
                              : quest.creatorUserId == null
                                  ? " "
                                  : quest.creatorUserId!)),
                      Text("Version " +
                          (quest.version == null
                              ? "0"
                              : quest.version!.toString())),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Câu hỏi',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      TextFormField(
                          maxLines: null,
                          readOnly: (quest.status == "KHAO_SAT_QUESTION")
                              ? true
                              : false,
                          controller: _questionContentController,
                          onChanged: (value) {
                            ques = value;
                          },
                          validator: (value) {
                            if (value == '') {
                              return 'Câu hỏi không thể để trống';
                            } else if (value.toString().length > 500) {
                              return 'Câu hỏi không thể lớn hơn 500 ký tự';
                            }
                          },
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black87, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2)),
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
                        if (quest.imageUrl != "")
                          SizedBox(
                            height: 200,
                            width: 400,
                            child: Image.network(quest.imageUrl!),
                          ),
                      if (quest.videoUrl != null)
                        if (quest.videoUrl != "")
                          SizedBox(
                              height: 300,
                              width: 400,
                              child: VideoItems(
                                videoPlayerController:
                                    VideoPlayerController.network(
                                        quest.videoUrl!),
                              )),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              (quest.status == "KHAO_SAT_QUESTION")
                                  ? 'Lựa chọn'
                                  : 'Đáp án',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      TextFormField(
                          readOnly: (quest.status == "KHAO_SAT_QUESTION")
                              ? true
                              : false,
                          maxLines: null,
                          controller: _answersCorrectController,
                          onChanged: (value) {
                            answerContent.first = value;
                          },
                          validator: (value) {
                            if (value == '') {
                              return 'Đáp án không thể để trống';
                            } else if (value.toString().length > 50) {
                              return 'Đáp án không thể lớn hơn 50 ký tự';
                            }
                          },
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black87, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2)),
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
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              (quest.status == "KHAO_SAT_QUESTION")
                                  ? 'Lựa chọn'
                                  : 'Câu sai 1',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      TextFormField(
                          readOnly: (quest.status == "KHAO_SAT_QUESTION")
                              ? true
                              : false,
                          maxLines: null,
                          controller: _answers1Controller,
                          onChanged: (value) {
                            answerContent[1] = value;
                          },
                          validator: (value) {
                            if (value == '') {
                              return 'không thể để trống câu sai';
                            } else if (value.toString().length > 50) {
                              return 'Câu sai không thể lớn hơn 50 ký tự';
                            }
                          },
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black87, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * errorFormMessage),
                            prefixIcon: Icon(
                              (quest.status == "KHAO_SAT_QUESTION")
                                  ? Icons.check_circle_outline
                                  : Icons.clear_sharp,
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
                          child: Text(
                              (quest.status == "KHAO_SAT_QUESTION")
                                  ? 'Lựa chọn'
                                  : 'Câu sai 2',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      TextFormField(
                          readOnly: (quest.status == "KHAO_SAT_QUESTION")
                              ? true
                              : false,
                          maxLines: null,
                          controller: _answers2Controller,
                          onChanged: (value) {
                            answerContent[2] = value;
                          },
                          validator: (value) {
                            if (value == '') {
                              return 'không thể để trống câu sai';
                            } else if (value.toString().length > 50) {
                              return 'Câu sai không thể lớn hơn 50 ký tự';
                            }
                          },
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black87, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * errorFormMessage),
                            prefixIcon: Icon(
                              (quest.status == "KHAO_SAT_QUESTION")
                                  ? Icons.check_circle_outline
                                  : Icons.clear_sharp,
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
                          child: Text(
                              (quest.status == "KHAO_SAT_QUESTION")
                                  ? 'Lựa chọn'
                                  : 'Câu sai 3',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      TextFormField(
                          readOnly: (quest.status == "KHAO_SAT_QUESTION")
                              ? true
                              : false,
                          maxLines: null,
                          controller: _answers3Controller,
                          onChanged: (value) {
                            answerContent[3] = value;
                          },
                          validator: (value) {
                            if (value == '') {
                              return 'không thể để trống câu sai';
                            } else if (value.toString().length > 50) {
                              return 'Câu sai không thể lớn hơn 50 ký tự';
                            }
                          },
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black87, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightBlueAccent, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * errorFormMessage),
                            prefixIcon: Icon(
                              (quest.status == "KHAO_SAT_QUESTION")
                                  ? Icons.check_circle_outline
                                  : Icons.clear_sharp,
                              size: widthSize * iconFormSize,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      (quest.status == "KHAO_SAT_QUESTION")
                          ? Text("")
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Chỉ dẫn',
                                  style: TextStyle(
                                      fontSize: widthSize * fontSizeTextField,
                                      fontFamily: 'Poppins',
                                      color: Colors.white))),
                      (quest.status == "KHAO_SAT_QUESTION")
                          ? Text("")
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Khái quát',
                                  style: TextStyle(
                                      fontSize: widthSize * fontSizeTextField,
                                      fontFamily: 'Poppins',
                                      color: Colors.white))),
                      (quest.status == "KHAO_SAT_QUESTION")
                          ? Text("")
                          : TextFormField(
                              maxLines: null,
                              controller: _descriptController,
                              validator: (value) {
                                if (value == '') {
                                  return 'không thể để trống Khái quát';
                                } else if (value.toString().length > 500) {
                                  return 'Khái quát không thể lớn hơn 500 ký tự';
                                }
                              },
                              cursorColor: Colors.white,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black87, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.lightBlueAccent,
                                        width: 2)),
                                labelStyle: TextStyle(color: Colors.white),
                                errorStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: widthSize * errorFormMessage),
                                prefixIcon: Icon(
                                  Icons.description_outlined,
                                  size: widthSize * iconFormSize,
                                  color: Colors.white,
                                ),
                              ),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      (quest.status == "KHAO_SAT_QUESTION")
                          ? Text("")
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Độ khó',
                                  style: TextStyle(
                                      fontSize: widthSize * fontSizeTextField,
                                      fontFamily: 'Poppins',
                                      color: Colors.white))),
                      (quest.status == "KHAO_SAT_QUESTION")
                          ? Text("")
                          : DropdownButton(
                              icon: const Icon(
                                Icons.arrow_downward,
                                color: Colors.white,
                              ),
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
                                  check++;
                                  if (ques != '') {
                                    _questionContentController.text = ques;
                                  }
                                  _answersCorrectController.text =
                                      answerContent[0];
                                  _answers1Controller.text = answerContent[1];
                                  _answers2Controller.text = answerContent[2];
                                  _answers3Controller.text = answerContent[3];
                                });
                              },
                              hint: Text("Select item")),
                      SizedBox(height: heightSize * spaceBetweenFieldAndButton),
                      (quest.status == "KHAO_SAT_QUESTION")
                          ? Text("")
                          : TextButton(
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
                                  if (answerContent.toSet().toList().length <
                                      4) {
                                    Get.snackbar('Thông báo',
                                        'Câu trả lời không được trùng',
                                        duration: Duration(seconds: 4),
                                        animationDuration:
                                            Duration(milliseconds: 800),
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor: Colors.white);
                                  } else {
                                    updateQuestion(
                                            quest.questionId!,
                                            _questionContentController.text,
                                            _value,
                                            answerId,
                                            answerContent,
                                            _descriptController.text,
                                            video,
                                            image)
                                        .catchError((error) {
                                      Get.snackbar('Thông báo', 'Nhập thất bại',
                                          duration: Duration(seconds: 4),
                                          animationDuration:
                                              Duration(milliseconds: 800),
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor: Colors.white);
                                    });
                                  }
                                }
                              },
                              child: Text('Cập nhật câu hỏi',
                                  style: TextStyle(
                                      fontSize: widthSize * fontSizeButton,
                                      fontFamily: 'Poppins',
                                      color: Colors.white))),
                      SizedBox(height: heightSize * spaceBetweenFields),
                    ])));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        });
  }
}
