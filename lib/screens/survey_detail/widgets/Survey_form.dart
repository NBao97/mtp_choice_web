import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtp_choice_web/models/SurveyFile.dart';
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
  late Future<List<Survey>> futureDataAllSurvey;
  String qus = constant.questId;

  @override
  void initState() {
    super.initState();
    futureDataAllSurvey = fetchSurAll(qus);
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
        future: futureDataAllSurvey,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Survey quest = snapshot.data!.single;
            (DateTime.now().isBefore(DateTime.parse(quest.startTime!)) ||
                    DateTime.now().isAfter(DateTime.parse(quest.endTime!)))
                ? constant.order = "Delete"
                : constant.order = "";

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
                      Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(color: Colors.white),
                          )),
                          child: Text(
                            quest.description == null ? "" : quest.description!,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSizeTextFormField),
                          )),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Ngày bắt đầu',
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
                          child: Text(
                              (quest.startTime == null) ? "" : quest.startTime!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontSizeTextFormField))),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Ngày kết thúc',
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
                          child: Text(
                              (quest.endTime == null) ? "" : quest.endTime!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontSizeTextFormField))),
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
                                Container(
                                    margin: const EdgeInsets.all(15.0),
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(color: Colors.white),
                                    )),
                                    child: Text(
                                        (hi.questionContent == null)
                                            ? ""
                                            : hi.questionContent!,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: fontSizeTextFormField))),
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
                                            Chart(hi.answe!),
                                          Row(children: [
                                            SizedBox(
                                              width: 500,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text('câu trả lời',
                                                          style: TextStyle(
                                                              fontSize: widthSize *
                                                                  fontSizeTextField,
                                                              fontFamily:
                                                                  'Poppins',
                                                              color: Colors
                                                                  .white))),
                                                  Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                      child: Wrap(
                                                        children: [
                                                          Text(
                                                              an.answerContent!
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      fontSizeTextFormField))
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            SizedBox(
                                              width: 100,
                                              child: Column(
                                                children: [
                                                  Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text('Phần trăm',
                                                          style: TextStyle(
                                                              fontSize: widthSize *
                                                                  fontSizeTextField,
                                                              fontFamily:
                                                                  'Poppins',
                                                              color: Colors
                                                                  .white))),
                                                  Text(
                                                      an.answerPercent
                                                          .toString(),
                                                      //an.answerPercent!.toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              fontSizeTextFormField)),
                                                ],
                                              ),
                                            )
                                          ])
                                        ])),
                                SizedBox(
                                    height: heightSize * spaceBetweenFields),
                              ])),
                      SizedBox(height: heightSize * spaceBetweenFieldAndButton)
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
  Chart(this.a);
  final List<Answers> a;

  @override
  Widget build(BuildContext context) {
    List color = [
      Colors.white,
      Color(0xFF26E5FF),
      Colors.green,
      Colors.deepOrange,
      Colors.greenAccent,
      Colors.blueAccent,
      Colors.yellowAccent,
      Colors.blueAccent,
      Colors.orange,
      Colors.amber
    ];
    List radi = [25, 23, 20, 18, 16, 14, 12, 10, 8, 5];
    double d = 0;
    int i = 0;
    for (Answers an in a) {
      d = d + an.answerPercent!;
    }
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
                for (i = 0; i < a.length; i++)
                  PieChartSectionData(
                    color: color[i],
                    value: a[i].answerPercent != null ? a[i].answerPercent : 0,
                    showTitle: true,
                    radius: radi[i],
                  ),
                PieChartSectionData(
                  color: Colors.deepOrange,
                  value: 100 - d,
                  showTitle: true,
                  title: 'Chưa có người chọn',
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
