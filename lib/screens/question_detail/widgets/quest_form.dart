import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtp_choice_web/models/QuestFile.dart';
import 'package:mtp_choice_web/models/RecentFile.dart';

class AcceptForm extends StatefulWidget {
  AcceptForm({Key? key}) : super(key: key);

  @override
  _AddFormState createState() {
    return _AddFormState(
        0, 0.01, 18, 0.08, 0.02, 0.08, 150, 0.02, 0.014, 0.02, 0.012);
  }
}

class _AddFormState extends State<AcceptForm> {
  final _formKey = GlobalKey<FormState>();
  // final _usernameController = TextEditingController();
  late Future<List<QuestionFile>> futureData;
  @override
  void initState() {
    super.initState();
    futureData = fetchQuestion(0);
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

    return FutureBuilder<List<QuestionFile>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final quest = snapshot.data!.first;
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
                      Text(quest.questionContent!,
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
                      Text(quest.difficulty!,
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
                      Text(quest.creator!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      // Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Text('Câu sai 2',
                      //         style: TextStyle(
                      //             fontSize: widthSize * fontSizeTextField,
                      //             fontFamily: 'Poppins',
                      //             color: Colors.white))),
                      // Text('nội dung câu sai 2',
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: fontSizeTextFormField)),
                      // SizedBox(height: heightSize * spaceBetweenFields),
                      // Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Text('Câu sai 3',
                      //         style: TextStyle(
                      //             fontSize: widthSize * fontSizeTextField,
                      //             fontFamily: 'Poppins',
                      //             color: Colors.white))),
                      // Text('nội dung câu sai 3',
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: fontSizeTextFormField)),
                      // SizedBox(height: heightSize * spaceBetweenFieldAndButton),
                    ])));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        });
  }
}
