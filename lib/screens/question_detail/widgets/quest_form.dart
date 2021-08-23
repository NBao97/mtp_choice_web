import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mtp_choice_web/controllers/VideoController.dart';
import 'package:mtp_choice_web/models/QuestFile.dart';
import 'package:mtp_choice_web/models/RecentFile.dart';
import '../../../constants.dart' as constant;
import 'package:video_player/video_player.dart';

class AcceptForm extends StatefulWidget {
  AcceptForm({Key? key}) : super(key: key);

  @override
  _AddFormState createState() {
    return _AddFormState(
        0, 0.01, 18, 0.08, 0.02, 0.08, 150, 0.02, 0.014, 0.02, 0.012);
  }
}

class _AddFormState extends State<AcceptForm> {
  GlobalKey<FormState> _formQus =
      new GlobalKey<FormState>(debugLabel: '_UpQusFormState');
  // final _usernameController = TextEditingController();
  late Future<List<QuestionFile>> futureDataQuestForm;
  final String qus = constant.questId;
  int _value = 0;
  @override
  void initState() {
    super.initState();
    futureDataQuestForm = fetchQuestion(constant.page, constant.order, qus);
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

    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Colors.white,
      padding: EdgeInsets.fromLTRB(widthButton, 15, widthButton, 15),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      backgroundColor: Colors.blue,
    );
    return FutureBuilder<List<QuestionFile>>(
        future: futureDataQuestForm,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final QuestionFile quest = snapshot.data!.single;

            constant.status = quest.status!;
            final _descriptController = TextEditingController(
                text: quest.questionDescription == null
                    ? ""
                    : quest.questionDescription);
            return Form(
                key: _formQus,
                child: Padding(
                    padding: EdgeInsets.only(
                        left: widthSize * 0.04,
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
                      TextFormField(
                          readOnly: true,
                          initialValue: quest.questionContent!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      if (quest.imageUrl != null)
                        if (quest.imageUrl != "")
                          SizedBox(
                            height: 300,
                            width: 400,
                            child: Image.network(quest.imageUrl!),
                          ),
                      if (quest.videoUrl != null)
                        if (quest.videoUrl != "")
                          VideoItems(
                            videoPlayerController:
                                VideoPlayerController.network(quest.videoUrl!),
                          ),
                      SizedBox(height: heightSize * spaceBetweenFields),
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

                                  // _answers1Controller.text = answerContent[1];
                                  // _answers1Controller.text = answerContent[1];
                                });
                              },
                              hint: Text("Select item")),
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
                                } else if (value.toString().length > 250) {
                                  return 'Khái quát không thể lớn hơn 250 ký tự';
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
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Người tạo',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(color: Colors.white),
                          )),
                          child: TextFormField(
                              readOnly: true,
                              initialValue:
                                  (quest.creator == null) ? "" : quest.creator!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontSizeTextFormField))),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      if (quest.ans!.isNotEmpty)
                        for (Answers ans in quest.ans!)
                          Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        (quest.status == "KHAO_SAT_QUESTION")
                                            ? "Lựa chọn"
                                            : (ans.isCorrect == true)
                                                ? 'Đáp án'
                                                : 'Câu sai',
                                        style: TextStyle(
                                            fontSize:
                                                widthSize * fontSizeTextField,
                                            fontFamily: 'Poppins',
                                            color: Colors.white))),
                                Container(
                                    margin: const EdgeInsets.all(15.0),
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(color: Colors.white),
                                    )),
                                    child: TextFormField(
                                        readOnly: true,
                                        initialValue:
                                            (ans.answerContent == null)
                                                ? ''
                                                : ans.answerContent!,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: fontSizeTextFormField))),
                                SizedBox(
                                    height: heightSize * spaceBetweenFields),
                              ]))
                      else
                        Text('Xin lỗi chúng tôi đang gặp một số vấn đề'),
                      TextButton(
                          style: flatButtonStyle,
                          onPressed: () async {
                            if (_formQus.currentState!.validate()) {
                              updateQuestion(
                                      quest.questionId!,
                                      quest.questionContent!,
                                      _value,
                                      [
                                        quest.ans!.first.questionId,
                                        quest.ans![1].questionId,
                                        quest.ans![2].questionId,
                                        quest.ans![3].questionId
                                      ],
                                      [
                                        quest.ans!.first.answerContent,
                                        quest.ans![1].answerContent,
                                        quest.ans![2].answerContent,
                                        quest.ans![3].answerContent
                                      ],
                                      _descriptController.text)
                                  .catchError((error) {
                                Get.snackbar(
                                    'Thông báo', 'Nhập thất bại ' + error,
                                    duration: Duration(seconds: 4),
                                    animationDuration:
                                        Duration(milliseconds: 800),
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: Colors.white);
                              });
                            }
                          },
                          child: Text('Cập nhật chỉ dẫn',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeButton,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                    ])));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        });
  }
}
