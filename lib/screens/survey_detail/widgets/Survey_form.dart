import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtp_choice_web/models/SurveyFile.dart';
import '../../../constants.dart' as constant;
import '../../../constants.dart';

class AcceptForm extends StatefulWidget {
  AcceptForm({Key? key}) : super(key: key);

  @override
  _AddFormState createState() {
    return _AddFormState(
        0, 0.01, 18, 0.08, 0.02, 0.08, 150, 0.02, 0.014, 0.02, 0.012);
  }
}

class _AddFormState extends State<AcceptForm> {
  late Future<List<Survey>> futureData;
  String qus = constant.questId;

  @override
  void initState() {
    super.initState();
    futureData = fetchSurAll(qus);
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
    // final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    //   primary: Colors.white,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(5.0)),
    //   ),
    //   backgroundColor: Colors.blue,
    // );
    return FutureBuilder<List<Survey>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Survey quest = snapshot.data!.single;

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
                          child: Text('Nội dung:',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      Text(quest.description == null ? "" : quest.description!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Ngày bắt đầu',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      Text((quest.startTime == null) ? "" : quest.startTime!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Ngày kết thúc',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      Text((quest.endTime == null) ? "" : quest.endTime!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFields),

                      if (quest.qus!.isNotEmpty)
                        for (Questions hi in quest.qus!)
                          Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Câu hỏi',
                                        style: TextStyle(
                                            fontSize:
                                                widthSize * fontSizeTextField,
                                            fontFamily: 'Poppins',
                                            color: Colors.white))),
                                Text(
                                    (hi.questionContent == null)
                                        ? ""
                                        : hi.questionContent!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSizeTextFormField)),
                                SizedBox(
                                    height: heightSize * spaceBetweenFields),
                                SizedBox(
                                    height: heightSize * spaceBetweenFields),
                                if (hi.answe!.isNotEmpty)
                                  for (Answers an in hi.answe!)
                                    Container(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          if (hi.answe!.first.answerId ==
                                              an.answerId)
                                            Chart(
                                                hi.answe!.first.answerPercent!,
                                                hi.answe![1].answerPercent!,
                                                hi.answe![2].answerPercent!,
                                                hi.answe![3].answerPercent!),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('câu trả lời',
                                                  style: TextStyle(
                                                      fontSize: widthSize *
                                                          fontSizeTextField,
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white))),
                                          Text(an.answerContent!.toString(),
                                              // (an.answerContent == null)
                                              //     ? ""
                                              //     : an.answerContent!
                                              //         .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      fontSizeTextFormField)),
                                          SizedBox(
                                              height: heightSize *
                                                  spaceBetweenFields),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('Phần trăm',
                                                  style: TextStyle(
                                                      fontSize: widthSize *
                                                          fontSizeTextField,
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white))),
                                          Text(an.answerPercent.toString(),
                                              //an.answerPercent!.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      fontSizeTextFormField)),
                                        ])),
                                SizedBox(
                                    height: heightSize * spaceBetweenFields),
                              ])),
                      SizedBox(height: heightSize * spaceBetweenFieldAndButton)
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

class Chart extends StatelessWidget {
  Chart(this.a, this.b, this.c, this.d);
  final double a, b, c, d;

  @override
  Widget build(BuildContext context) {
    var nlist = [a, b, c, d];
    nlist.sort((a, b) => a.compareTo(b));
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: [
                PieChartSectionData(
                  color: primaryColor,
                  value: nlist.first,
                  showTitle: true,
                  radius: 25,
                ),
                PieChartSectionData(
                  color: Color(0xFF26E5FF),
                  value: nlist[1],
                  showTitle: true,
                  radius: 20,
                ),
                PieChartSectionData(
                  color: primaryColor.withOpacity(0.1),
                  value: nlist[2],
                  showTitle: true,
                  radius: 15,
                ),
                PieChartSectionData(
                  color: Color(0xffb74093),
                  value: nlist.last,
                  showTitle: true,
                  radius: 12,
                ),
                PieChartSectionData(
                  color: Colors.deepOrange,
                  value: 100 - (nlist.first + nlist.last + nlist[1] + nlist[2]),
                  showTitle: true,
                  title: 'Not Started',
                  radius: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
