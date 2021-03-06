import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/models/SurveyFile.dart';

import '../create_survey.dart';

List question = [];
List answer = [];
TextEditingController _descriptionController = TextEditingController(text: " ");
TextEditingController _endTimeController = TextEditingController();

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _MyAppState createState() =>
      _MyAppState(0, 0.01, 18, 0.08, 0.02, 0.08, 150, 0.02, 0.014, 0.02, 0.012);
}

class _MyAppState extends State<UpdateProfile> {
  @override
  void initState() {
    question.clear();
    answer.clear();
    _descriptionController.clear();
    _endTimeController.clear();
    super.initState();
  }

  static List<String> friendsList = [""];

  DateTime currentDate = DateTime.now();
  GlobalKey<FormState> _formKey =
      new GlobalKey<FormState>(debugLabel: '_UpUserSFormState');

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

  _MyAppState(
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
      padding: EdgeInsets.fromLTRB(widthButton / 2, 15, widthButton / 2, 15),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      backgroundColor: Colors.blue,
    );
    final ButtonStyle flatButtonStyle2 = TextButton.styleFrom(
      primary: Colors.white,
      padding: EdgeInsets.fromLTRB(widthButton, 15, widthButton, 15),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      backgroundColor: Colors.blue,
    );
    // TextEditingController _startTimeController = TextEditingController();

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
                  child: Text('N???i dung kh???o s??t',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == '') {
                      return 'N???i dung kh??ng th??? ????? tr???ng';
                    } else if (value.toString().length > 500) {
                      return 'N???i dung kh??ng th??? l???n h??n 500 k?? t???';
                    } else if (value.toString().length < 20) {
                      return 'N???i dung kh??ng th??? nh??? h??n 20 k?? t???';
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
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
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
                      color: Colors.white, fontSize: fontSizeTextFormField)),
              SizedBox(height: heightSize * spaceBetweenFields / 2),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('Ng??y k???t th??c',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  readOnly: true,
                  controller: _endTimeController,
                  validator: (value) {
                    if (value == '') {
                      return 'N???i dung kh??ng th??? ????? tr???ng';
                    } else if (DateTime.parse(value!).isBefore(
                        DateTime.parse(DateTime.now().toIso8601String()))) {
                      return 'Ng??y k???t th??c kh??ng th??? x???y ra trong qu?? kh???';
                    }
                  },
                  onTap: () async {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2019, 1),
                      lastDate: DateTime(2021, 12),
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: Colors.blueAccent,
                            accentColor: const Color(0xFF8CE7F1),
                            colorScheme:
                                ColorScheme.light(primary: Colors.blueAccent),
                            buttonTheme: ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                          ),
                          child: child!,
                        );
                      },
                    ).then((pickedDate) {
                      //do whatever you want
                      _endTimeController.text = pickedDate!.toIso8601String();
                    });
                  },
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black87, width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
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
                      color: Colors.white, fontSize: fontSizeTextFormField)),
              SizedBox(
                height: heightSize * spaceBetweenFields,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text('B???ng c??u h???i',
                      style: TextStyle(
                          fontSize: fontSizeTextFormField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              SizedBox(
                height: heightSize * spaceBetweenFields,
              ),
              ..._getFriends(),
              SizedBox(
                height: heightSize * spaceBetweenFields,
              ),
              Row(
                children: [
                  Row(children: [
                    TextButton(
                        style: flatButtonStyle,
                        onPressed: () async {
                          question.clear();
                          answer.clear();
                          Form.of(primaryFocus!.context!)!.save();
                          if (_formKey.currentState!.validate()) {
                            // _startTimeController.text                               _endTimeController.text,
                            postSurvey(
                                    _descriptionController.text,
                                    DateTime.now().toIso8601String(),
                                    _endTimeController.text,
                                    question,
                                    answer)
                                .catchError((error) {
                              print(error);
                            });
                          }
                        },
                        child: Text('T???o kh???o s??t',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                color: Colors.white)))
                  ]),
                  Spacer(),
                  Row(children: [
                    TextButton(
                        style: flatButtonStyle2,
                        onPressed: () async {
                          Get.back();
                          Get.toNamed(CreateSurvey.route);
                        },
                        child: Text('T???o kh???o s??t kh??c',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                color: Colors.white)))
                  ]),
                ],
              ),
              SizedBox(height: heightSize * spaceBetweenFieldAndButton),
            ])));
  }

  List<Widget> _getFriends() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < friendsList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text('C??u h???i ' + (i + 1).toString(),
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.01,
                        fontFamily: 'Poppins',
                        color: Colors.white))),
            Expanded(child: FriendTextFields(i)),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(i == friendsList.length - 1, i),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          friendsList.insert(0, "");
        } else
          friendsList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

class FriendTextFields extends StatefulWidget {
  final int index;
  FriendTextFields(this.index);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 2)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text('C??u h???i',
                  style: TextStyle(
                      fontSize: widthSize * 0.01,
                      fontFamily: 'Poppins',
                      color: Colors.white))),
          TextFormField(
              maxLines: null,
              validator: (value) {
                if (value == '') {
                  return 'C??u h???i kh??ng th??? ????? tr???ng';
                } else if (value.toString().length > 500) {
                  return 'C??u h???i kh??ng th??? l???n h??n 500 k?? t???';
                }
              },
              onSaved: (value) {
                question.add(value);
              },
              cursorColor: Colors.white,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87, width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2)),
                labelStyle: TextStyle(color: Colors.white),
                errorStyle:
                    TextStyle(color: Colors.white, fontSize: widthSize * 0.012),
                prefixIcon: Icon(
                  Icons.chat_outlined,
                  size: widthSize * 0.02,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white, fontSize: 18)),
          SizedBox(height: heightSize * 0.08 / 2),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                width: widthSize / 6,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('L???a ch???n b???t bu???c',
                              style: TextStyle(
                                  fontSize: widthSize * 0.01,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      TextFormField(
                          maxLines: null,
                          validator: (value) {
                            if (value == '') {
                              return 'L???a ch???n b???t bu???c kh??ng th??? ????? tr???ng';
                            } else if (value.toString().length > 50) {
                              return 'L???a ch???n kh??ng th??? l???n h??n 50 k?? t???';
                            }
                          },
                          onSaved: (value) {
                            answer.add(value);
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
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * 0.012),
                            prefixIcon: Icon(
                              Icons.check_circle_outline,
                              size: widthSize * 0.02,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ])),
            Spacer(),
            Container(
                width: widthSize / 6,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('L???a ch???n b???t bu???c',
                              style: TextStyle(
                                  fontSize: widthSize * 0.01,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      TextFormField(
                          maxLines: null,
                          validator: (value) {
                            if (value == '') {
                              return 'L???a ch???n b???t bu???c kh??ng th??? ????? tr???ng';
                            } else if (value.toString().length > 50) {
                              return 'L???a ch???n kh??ng th??? l???n h??n 50 k?? t???';
                            }
                          },
                          onSaved: (value) {
                            answer.add(value);
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
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * 0.012),
                            prefixIcon: Icon(
                              Icons.check_circle_outline,
                              size: widthSize * 0.02,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ]))
          ]),
          SizedBox(height: heightSize * 0.08 / 2),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                width: widthSize / 6,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('L???a ch???n',
                              style: TextStyle(
                                  fontSize: widthSize * 0.01,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      TextFormField(
                          maxLines: null,
                          validator: (value) {
                            if (value.toString().length > 50) {
                              return 'L???a ch???n kh??ng th??? l???n h??n 50 k?? t???';
                            }
                          },
                          onSaved: (value) {
                            answer.add(value);
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
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * 0.012),
                            prefixIcon: Icon(
                              Icons.check_circle_outline,
                              size: widthSize * 0.02,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ])),
            Spacer(),
            Container(
                width: widthSize / 6,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('L???a ch???n',
                              style: TextStyle(
                                  fontSize: widthSize * 0.01,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      TextFormField(
                          maxLines: null,
                          validator: (value) {
                            if (value.toString().length > 50) {
                              return 'L???a ch???n kh??ng th??? l???n h??n 50 k?? t???';
                            }
                          },
                          onSaved: (value) {
                            answer.add(value);
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
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * 0.012),
                            prefixIcon: Icon(
                              Icons.check_circle_outline,
                              size: widthSize * 0.02,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ]))
          ]),
          SizedBox(height: heightSize * 0.08 / 2),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                width: widthSize / 6,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('L???a ch???n',
                              style: TextStyle(
                                  fontSize: widthSize * 0.01,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      TextFormField(
                          maxLines: null,
                          validator: (value) {
                            if (value.toString().length > 50) {
                              return 'L???a ch???n kh??ng th??? l???n h??n 50 k?? t???';
                            }
                          },
                          onSaved: (value) {
                            answer.add(value);
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
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * 0.012),
                            prefixIcon: Icon(
                              Icons.check_circle_outline,
                              size: widthSize * 0.02,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ])),
            Spacer(),
            Container(
                width: widthSize / 6,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('L???a ch???n',
                              style: TextStyle(
                                  fontSize: widthSize * 0.01,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      TextFormField(
                          maxLines: null,
                          validator: (value) {
                            if (value.toString().length > 50) {
                              return 'L???a ch???n kh??ng th??? l???n h??n 50 k?? t???';
                            }
                          },
                          onSaved: (value) {
                            answer.add(value);
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
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * 0.012),
                            prefixIcon: Icon(
                              Icons.check_circle_outline,
                              size: widthSize * 0.02,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ]))
          ]),
          SizedBox(height: heightSize * 0.08 / 2),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                width: widthSize / 6,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('L???a ch???n',
                              style: TextStyle(
                                  fontSize: widthSize * 0.01,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      TextFormField(
                          maxLines: null,
                          validator: (value) {
                            if (value.toString().length > 50) {
                              return 'L???a ch???n kh??ng th??? l???n h??n 50 k?? t???';
                            }
                          },
                          onSaved: (value) {
                            answer.add(value);
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
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * 0.012),
                            prefixIcon: Icon(
                              Icons.check_circle_outline,
                              size: widthSize * 0.02,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ])),
            Spacer(),
            Container(
                width: widthSize / 6,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('L???a ch???n',
                              style: TextStyle(
                                  fontSize: widthSize * 0.01,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      TextFormField(
                          maxLines: null,
                          validator: (value) {
                            if (value.toString().length > 50) {
                              return 'L???a ch???n kh??ng th??? l???n h??n 50 k?? t???';
                            }
                          },
                          onSaved: (value) {
                            answer.add(value);
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
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * 0.012),
                            prefixIcon: Icon(
                              Icons.check_circle_outline,
                              size: widthSize * 0.02,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ]))
          ]),
          SizedBox(height: heightSize * 0.08 / 2),
        ]));
  }
}
