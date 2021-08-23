import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/models/RecentFile.dart';
import 'package:mtp_choice_web/screens/add/components/upload_button_vi.dart';

import 'dart:async';
import '../../../constants.dart' as constant;
import 'package:mtp_choice_web/models/QuestFile.dart';

import '../../../constants.dart';

class AddFileVi extends StatefulWidget {
  AddFileVi({Key? key}) : super(key: key);

  @override
  _AddFormState createState() {
    return _AddFormState(
        0, 0.01, 18, 0.08, 0.02, 0.08, 150, 0.02, 0.014, 0.02, 0.012);
  }
}

class _AddFormState extends State<AddFileVi> {
  GlobalKey<FormState> _formAdf =
      new GlobalKey<FormState>(debugLabel: '_AddFFormStateVi');
  final _questionContentController = TextEditingController();
  // final _difficultyController = TextEditingController(text: "0");
  final _answersCorrectController = TextEditingController();
  final _answers1Controller = TextEditingController();
  final _answers2Controller = TextEditingController();
  final _answers3Controller = TextEditingController();
  final _descriptController = TextEditingController();
  @override
  void initState() {
    super.initState();
    constant.imageUrl = '';
  }

  Future<QuestionFile>? _futureQuestion;

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
  int _value = 0;

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
        key: _formAdf,
        child: Padding(
          padding: EdgeInsets.only(
              left: widthSize * 0.05,
              right: widthSize * 0.05,
              top: heightSize * paddingTopForm),
          child: (_futureQuestion == null)
              ? Column(children: <Widget>[
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
                        } else if (value.toString().length > 150) {
                          return 'Câu hỏi không thể lớn hơn 150 ký tự';
                        }
                      },
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black87, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                        focusedBorder: OutlineInputBorder(
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
                  SizedBox(height: heightSize * spaceBetweenFields / 2),
                  FileUploadButton(),
                  SizedBox(height: heightSize * spaceBetweenFields / 2),
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
                        } else if (value.toString().length > 150) {
                          return 'Đáp án không thể lớn hơn 150 ký tự';
                        }
                      },
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black87, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                        focusedBorder: OutlineInputBorder(
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
                  SizedBox(height: heightSize * spaceBetweenFields / 2),
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
                        } else if (value.toString().length > 150) {
                          return 'Câu sai không thể lớn hơn 150 ký tự';
                        }
                      },
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black87, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                        focusedBorder: OutlineInputBorder(
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
                  SizedBox(height: heightSize * spaceBetweenFields / 2),
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
                        } else if (value.toString().length > 150) {
                          return 'Câu sai không thể lớn hơn 150 ký tự';
                        }
                      },
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black87, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                        focusedBorder: OutlineInputBorder(
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
                  SizedBox(height: heightSize * spaceBetweenFields / 2),
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
                        } else if (value.toString().length > 150) {
                          return 'Câu sai không thể lớn hơn 150 ký tự';
                        }
                      },
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black87, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                        focusedBorder: OutlineInputBorder(
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
                  SizedBox(height: heightSize * spaceBetweenFields / 2),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Độ khó',
                          style: TextStyle(
                              fontSize: widthSize * fontSizeTextField,
                              fontFamily: 'Poppins',
                              color: Colors.white))),
                  SizedBox(height: heightSize * spaceBetweenFields / 2),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Khái quát',
                          style: TextStyle(
                              fontSize: widthSize * fontSizeTextField,
                              fontFamily: 'Poppins',
                              color: Colors.white))),
                  TextFormField(
                      maxLines: null,
                      controller: _descriptController,
                      validator: (value) {
                        if (value == '') {
                          return 'không thể để trống khái quát';
                        } else if (value.toString().length > 250) {
                          return 'Khái quát không thể lớn hơn 250 ký tự';
                        }
                      },
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black87, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
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
                  SizedBox(height: heightSize * spaceBetweenFields / 2),
                  DropdownButton(
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
                        });
                      },
                      hint: Text("Select item")),
                  SizedBox(height: heightSize * spaceBetweenFieldAndButton),
                  TextButton(
                      style: flatButtonStyle,
                      onPressed: () async {
                        if (constant.imageUrl != '') {
                          final TaskSnapshot? avaSnapshot =
                              await uploadFile(context, constant.imageUrl);

                          if (avaSnapshot == null) {
                            Get.snackbar('Thông báo', 'Lưu video thất bại',
                                duration: Duration(seconds: 4),
                                animationDuration: Duration(milliseconds: 800),
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.white);
                          } else {
                            if (avaSnapshot.state == TaskState.success) {
                              constant.image =
                                  await avaSnapshot.ref.getDownloadURL();
                            }

                            List answerContent = [
                              _answersCorrectController.text,
                              _answers1Controller.text,
                              _answers2Controller.text,
                              _answers3Controller.text
                            ];
                            if (_formAdf.currentState!.validate()) {
                              if (answerContent.toSet().toList().length < 4) {
                                Get.snackbar(
                                    'Thông báo', 'Câu trả lời không được trùng',
                                    duration: Duration(seconds: 4),
                                    animationDuration:
                                        Duration(milliseconds: 800),
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: Colors.white);
                              } else {
                                createQuestionVi(
                                        _questionContentController.text,
                                        constant.userName,
                                        _value,
                                        _answersCorrectController.text,
                                        _answers1Controller.text,
                                        _answers2Controller.text,
                                        _answers3Controller.text,
                                        _descriptController.text)
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
                          }
                        }
                        Get.snackbar('Thông báo', 'Xin hãy nhập video',
                            duration: Duration(seconds: 4),
                            animationDuration: Duration(milliseconds: 800),
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.white);
                      },
                      child: Text('Thêm câu hỏi',
                          style: TextStyle(
                              fontSize: widthSize * fontSizeButton,
                              fontFamily: 'Poppins',
                              color: Colors.white))),
                  SizedBox(height: heightSize * 0.01),
                ])
              : buildFutureBuilder(),
        ));
  }

  FutureBuilder<QuestionFile> buildFutureBuilder() {
    return FutureBuilder<QuestionFile>(
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
