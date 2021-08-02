import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/constants.dart' as constant;
import 'package:mtp_choice_web/models/SurveyFile.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _MyAppState createState() =>
      _MyAppState(0, 0.01, 18, 0.08, 0.02, 0.08, 150, 0.02, 0.014, 0.02, 0.012);
}

class _MyAppState extends State<UpdateProfile> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey =
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
      padding: EdgeInsets.fromLTRB(widthButton, 15, widthButton, 15),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      backgroundColor: Colors.blue,
    );
    final _nameController = TextEditingController();

    final _descriptionController = TextEditingController();
    // final _quesController = TextEditingController();
    // final _ansTimeController = TextEditingController();
    //
    // final _startTimeController = TextEditingController();
    //
    // final _endTimeController = TextEditingController();
    List question = [];
    List answer = [];
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
                  child: Text('Tên khảo sát ',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == '') {
                      return 'Nhập tên khảo sát của bạn để tiếp tục';
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
                      color: Colors.white, fontSize: fontSizeTextFormField)),
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Nội dung khảo sát',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == '') {
                      return 'Nội dung không thể để trống';
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
              SizedBox(height: heightSize * spaceBetweenFields),
              // Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text('Ngày bắt đầu',
              //         style: TextStyle(
              //             fontSize: widthSize * fontSizeTextField,
              //             fontFamily: 'Poppins',
              //             color: Colors.white))),
              // Align(
              //     alignment: Alignment.centerLeft,
              //     child: TextFormField(
              //         controller: _startTimeController,
              //         onTap: () async {
              //           DateTime date = DateTime(1900);
              //           FocusScope.of(context).requestFocus(new FocusNode());
              //           date = (await showDatePicker(
              //             context: context,
              //             initialDate: DateTime.now(),
              //             firstDate: DateTime(2021, 1),
              //             lastDate: DateTime.now().add(Duration(days: 365)),
              //           ))!;
              //           _startTimeController.text = date.toIso8601String();
              //         },
              //         validator: (value) {
              //           if (value == null) {
              //             return 'Ô này không thể để trống';
              //           }
              //           if (value == DateTime(1900).toIso8601String()) {
              //             return 'Ô này không thể để trống';
              //           }
              //           return null;
              //         },
              //         cursorColor: Colors.white,
              //         keyboardType: TextInputType.text,
              //         decoration: InputDecoration(
              //           labelText: 'Xin hãy chọn  thời gian kết thúc',
              //           fillColor: Colors.white,
              //           border: UnderlineInputBorder(
              //               borderSide:
              //                   BorderSide(color: Colors.red, width: 2)),
              //           enabledBorder: UnderlineInputBorder(
              //               borderSide:
              //                   BorderSide(color: Colors.white, width: 2)),
              //           focusedBorder: UnderlineInputBorder(
              //               borderSide:
              //                   BorderSide(color: Colors.white, width: 2)),
              //           labelStyle: TextStyle(color: Colors.white),
              //           errorStyle: TextStyle(
              //               color: Colors.white,
              //               fontSize: widthSize * errorFormMessage),
              //           prefixIcon: Icon(
              //             Icons.check_circle_outline,
              //             size: widthSize * iconFormSize,
              //             color: Colors.white,
              //           ),
              //         ),
              //         textAlign: TextAlign.start,
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: widthSize * fontSizeTextFormField))),
              // Align(
              //     alignment: Alignment.topRight,
              //     child: Text('Ngày kết thúc',
              //         style: TextStyle(
              //             fontSize: widthSize * fontSizeTextField,
              //             fontFamily: 'Poppins',
              //             color: Colors.white))),
              // Align(
              //     alignment: Alignment.centerRight,
              //     child: TextFormField(
              //         controller: _endTimeController,
              //         onTap: () async {
              //           DateTime date = DateTime(1900);
              //           FocusScope.of(context).requestFocus(new FocusNode());
              //           date = (await showDatePicker(
              //             context: context,
              //             initialDate: DateTime.now(),
              //             firstDate: DateTime(2021, 1),
              //             lastDate: DateTime.now().add(Duration(days: 365)),
              //           ))!;
              //           _endTimeController.text = date.toIso8601String();
              //         },
              //         validator: (value) {
              //           if (value == null) {
              //             return 'Ô này không thể để trống';
              //           }
              //           if (value == DateTime(1900).toIso8601String()) {
              //             return 'Ô này không thể để trống';
              //           }
              //           if (DateTime.parse(value).isBefore(
              //               DateTime.parse(_startTimeController.text))) {
              //             return 'Ngày kết thúc phải trước ngày bắt đầu';
              //           }
              //           return null;
              //         },
              //         obscureText: true,
              //         cursorColor: Colors.white,
              //         keyboardType: TextInputType.text,
              //         decoration: InputDecoration(
              //           labelText: 'Xin hãy chọn  thời gian kết thúc',
              //           fillColor: Colors.white,
              //           border: UnderlineInputBorder(
              //               borderSide:
              //                   BorderSide(color: Colors.red, width: 2)),
              //           enabledBorder: UnderlineInputBorder(
              //               borderSide:
              //                   BorderSide(color: Colors.white, width: 2)),
              //           focusedBorder: UnderlineInputBorder(
              //               borderSide:
              //                   BorderSide(color: Colors.white, width: 2)),
              //           labelStyle: TextStyle(color: Colors.white),
              //           errorStyle: TextStyle(
              //               color: Colors.white,
              //               fontSize: widthSize * errorFormMessage),
              //           prefixIcon: Icon(
              //             Icons.check_circle_outline,
              //             size: widthSize * iconFormSize,
              //             color: Colors.white,
              //           ),
              //         ),
              //         textAlign: TextAlign.start,
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: widthSize * fontSizeTextFormField))),
              // SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Câu hỏi',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Câu hỏi không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    question.add(value);
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
                      color: Colors.white, fontSize: fontSizeTextFormField)),
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Câu hỏi',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Câu hỏi không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    question.add(value);
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
                      color: Colors.white, fontSize: fontSizeTextFormField)),
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Câu hỏi',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Câu hỏi không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    question.add(value);
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
                      color: Colors.white, fontSize: fontSizeTextFormField)),
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Câu hỏi',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Câu hỏi không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    question.add(value);
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
                      color: Colors.white, fontSize: fontSizeTextFormField)),
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Câu hỏi',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Câu hỏi không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    question.add(value);
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
                      color: Colors.white, fontSize: fontSizeTextFormField)),
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              SizedBox(height: heightSize * spaceBetweenFields),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Lựa chọn',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  maxLines: null,
                  validator: (value) {
                    if (value == '') {
                      return 'Lựa chọn không thể để trống';
                    }
                  },
                  onSaved: (value) {
                    answer.add(value);
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
              SizedBox(height: heightSize * spaceBetweenFields),
              SizedBox(height: heightSize * spaceBetweenFieldAndButton),
              TextButton(
                  style: flatButtonStyle,
                  onPressed: () async {
                    Form.of(primaryFocus!.context!)!.save();
                    if (_formKey.currentState!.validate()) {
                      // _startTimeController.text                               _endTimeController.text,
                      postSurvey(
                              _nameController.text,
                              _descriptionController.text,
                              DateTime.now()
                                  .add(Duration(days: 10))
                                  .toIso8601String(),
                              DateTime.now()
                                  .add(Duration(days: 365))
                                  .toIso8601String(),
                              question,
                              answer)
                          .then((result) async {
                        if (result != "") {
                          if (result.contains("Success")) {
                            // Form.of(primaryFocus!.context!)!.deactivate();
                          } else {
                            Get.snackbar('Alert', 'Thất bại' + result,
                                duration: Duration(seconds: 4),
                                animationDuration: Duration(milliseconds: 800),
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.white);
                          }
                        }
                      }).catchError((error) {
                        Get.snackbar('Alert', 'Nhập thất bại',
                            duration: Duration(seconds: 4),
                            animationDuration: Duration(milliseconds: 800),
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.white);
                      });
                    }
                  },
                  child: Text('Tạo khảo sát',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeButton,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              SizedBox(height: heightSize * 0.01),
            ])));
  }
}
