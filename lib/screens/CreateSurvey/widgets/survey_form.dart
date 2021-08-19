import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      padding: EdgeInsets.fromLTRB(widthButton, 15, widthButton, 15),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      backgroundColor: Colors.blue,
    );
    TextEditingController _nameController = TextEditingController();

    TextEditingController _descriptionController = TextEditingController();
    // final _quesController = TextEditingController();
    // final _ansTimeController = TextEditingController();

    TextEditingController _startTimeController = TextEditingController();

    TextEditingController _endTimeController = TextEditingController();
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
                      Icons.chat_outlined,
                      size: widthSize * iconFormSize,
                      color: Colors.white,
                    ),
                  ),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white, fontSize: fontSizeTextFormField)),
              SizedBox(height: heightSize * spaceBetweenFields / 2),
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
                  alignment: Alignment.centerLeft,
                  child: Text('Ngày bắt đầu',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  readOnly: true,
                  controller: _startTimeController,
                  validator: (value) {
                    if (value == '') {
                      return 'Nội dung không thể để trống';
                    } else if (DateTime.parse(value!)
                        .isAfter(DateTime.parse(_endTimeController.text))) {
                      return 'Ngày bắt đầu không thể xảy ra sau ngày kết thúc';
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
                      _startTimeController.text = pickedDate!.toIso8601String();
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
              SizedBox(height: heightSize * spaceBetweenFields / 2),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('Ngày kết thúc',
                      style: TextStyle(
                          fontSize: widthSize * fontSizeTextField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              TextFormField(
                  readOnly: true,
                  controller: _endTimeController,
                  validator: (value) {
                    if (value == '') {
                      return 'Nội dung không thể để trống';
                    } else if (DateTime.parse(value!)
                        .isBefore(DateTime.parse(_startTimeController.text))) {
                      return 'Ngày bắt đầu không thể xảy ra sau ngày kết thúc';
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
                  child: Text('Bảng câu hỏi',
                      style: TextStyle(
                          fontSize: fontSizeTextFormField,
                          fontFamily: 'Poppins',
                          color: Colors.white))),
              Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                      child: Text('Thêm câu hỏi',
                          style: TextStyle(
                              fontSize: fontSizeTextFormField,
                              fontFamily: 'Poppins',
                              color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                      ),
                      onPressed: () async {
                        setState(() {});
                      })),
              SizedBox(
                height: 610,
                width: 650,
                child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent, width: 2)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Câu hỏi 1',
                                  style: TextStyle(
                                      fontSize: widthSize * fontSizeTextField,
                                      fontFamily: 'Poppins',
                                      color: Colors.white))),
                          Align(
                              alignment: Alignment.topLeft,
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
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black87, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
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
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black87, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
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
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black87, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
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
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black87, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
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
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black87, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
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
                        ])),
              ),
              SizedBox(height: heightSize * spaceBetweenFieldAndButton),
              SizedBox(
                height: 610,
                width: 650,
                child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent, width: 2)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Câu hỏi 2',
                                  style: TextStyle(
                                      fontSize: widthSize * fontSizeTextField,
                                      fontFamily: 'Poppins',
                                      color: Colors.white))),
                          Align(
                              alignment: Alignment.topLeft,
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
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black87, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
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
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black87, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
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
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black87, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
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
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black87, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
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
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black87, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2)),
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
                        ])),
              ),
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
                              _startTimeController.text,
                              _endTimeController.text,
                              question,
                              answer)
                          .catchError((error) {
                        print(error);
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
