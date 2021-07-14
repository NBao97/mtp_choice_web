import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String title;

  Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

class AddForm extends StatefulWidget {
  AddForm({Key? key}) : super(key: key);

  @override
  _AddFormState createState() {
    return _AddFormState(
        0, 0.01, 18, 0.08, 0.02, 0.08, 150, 0.02, 0.014, 0.02, 0.012);
  }
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  Future<Album>? _futureAlbum;

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
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(
              left: widthSize * 0.05,
              right: widthSize * 0.05,
              top: heightSize * paddingTopForm),
          child: (_futureAlbum == null)
              ? buildColumn(widthSize, heightSize, flatButtonStyle)
              : buildFutureBuilder(),
        ));
  }

  Column buildColumn(
      double widthSize, double heightSize, ButtonStyle flatButtonStyle) {
    return Column(children: <Widget>[
      Align(
          alignment: Alignment.centerLeft,
          child: Text('Câu hỏi',
              style: TextStyle(
                  fontSize: widthSize * fontSizeTextField,
                  fontFamily: 'Poppins',
                  color: Colors.white))),
      TextFormField(
          maxLines: null,
          // controller: _usernameController,
          validator: (value) {
            if (value == '') {
              return 'Nhập tên người dùng của bạn để tiếp tục';
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
                color: Colors.white, fontSize: widthSize * errorFormMessage),
            prefixIcon: Icon(
              Icons.chat_outlined,
              size: widthSize * iconFormSize,
              color: Colors.white,
            ),
          ),
          textAlign: TextAlign.start,
          style:
              TextStyle(color: Colors.white, fontSize: fontSizeTextFormField)),
      SizedBox(height: heightSize * spaceBetweenFields),
      Align(
          alignment: Alignment.centerLeft,
          child: Text('Đáp án',
              style: TextStyle(
                  fontSize: widthSize * fontSizeTextField,
                  fontFamily: 'Poppins',
                  color: Colors.white))),
      TextFormField(
          maxLines: null,
          // controller: _usernameController,
          validator: (value) {
            if (value == '') {
              return 'Nhập tên người dùng của bạn để tiếp tục';
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
                color: Colors.white, fontSize: widthSize * errorFormMessage),
            prefixIcon: Icon(
              Icons.check_circle_outline,
              size: widthSize * iconFormSize,
              color: Colors.white,
            ),
          ),
          textAlign: TextAlign.start,
          style:
              TextStyle(color: Colors.white, fontSize: fontSizeTextFormField)),
      SizedBox(height: heightSize * spaceBetweenFields),
      Align(
          alignment: Alignment.centerLeft,
          child: Text('Câu sai 1',
              style: TextStyle(
                  fontSize: widthSize * fontSizeTextField,
                  fontFamily: 'Poppins',
                  color: Colors.white))),
      TextFormField(
          maxLines: null,
          //  controller: _usernameController,
          validator: (value) {
            if (value == '') {
              return 'Nhập tên người dùng của bạn để tiếp tục';
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
                color: Colors.white, fontSize: widthSize * errorFormMessage),
            prefixIcon: Icon(
              Icons.clear_sharp,
              size: widthSize * iconFormSize,
              color: Colors.white,
            ),
          ),
          textAlign: TextAlign.start,
          style:
              TextStyle(color: Colors.white, fontSize: fontSizeTextFormField)),
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
          //    controller: _usernameController,
          validator: (value) {
            if (value == '') {
              return 'Nhập tên người dùng của bạn để tiếp tục';
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
                color: Colors.white, fontSize: widthSize * errorFormMessage),
            prefixIcon: Icon(
              Icons.clear_sharp,
              size: widthSize * iconFormSize,
              color: Colors.white,
            ),
          ),
          textAlign: TextAlign.start,
          style:
              TextStyle(color: Colors.white, fontSize: fontSizeTextFormField)),
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
          //  controller: _usernameController,
          validator: (value) {
            if (value == '') {
              return 'Nhập tên người dùng của bạn để tiếp tục';
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
                color: Colors.white, fontSize: widthSize * errorFormMessage),
            prefixIcon: Icon(
              Icons.clear_sharp,
              size: widthSize * iconFormSize,
              color: Colors.white,
            ),
          ),
          textAlign: TextAlign.start,
          style:
              TextStyle(color: Colors.white, fontSize: fontSizeTextFormField)),
      SizedBox(height: heightSize * spaceBetweenFieldAndButton),
      TextButton(
          style: flatButtonStyle,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {}
          },
          child: Text('Thêm câu hỏi',
              style: TextStyle(
                  fontSize: widthSize * fontSizeButton,
                  fontFamily: 'Poppins',
                  color: Colors.white))),
      SizedBox(height: heightSize * 0.01),
    ]);
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }
}
