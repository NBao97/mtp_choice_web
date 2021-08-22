import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mtp_choice_web/constants.dart' as constant;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

Future<String> createQuestion(
    String title,
    String creator,
    int difficult,
    String rightAns,
    String as1,
    String as2,
    String as3,
    String questionDescription,
    String questionHint) async {
  var list = [rightAns, as1, as2, as3];
  list = list..shuffle();

  final response =
      await http.post(Uri.parse('https://api.wimln.ml/api/Question'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + constant.key,
          },
          body: "[" +
              jsonEncode(<String, dynamic>{
                "questionContent": title,
                "difficulty": difficult,
                "creator": "",
                "questionDescription": questionDescription,
                "questionHint": questionHint,
                "imageUrl": constant.image,
                "status": 1,
                "answers": [
                  {
                    "answerContent": list.first,
                    "isCorrect": list.first == rightAns ? true : false,
                    "status": 1
                  },
                  {
                    "answerContent": list.elementAt(1),
                    "isCorrect": list.elementAt(1) == rightAns ? true : false,
                    "status": 1
                  },
                  {
                    "answerContent": list.elementAt(2),
                    "isCorrect": list.elementAt(2) == rightAns ? true : false,
                    "status": 1
                  },
                  {
                    "answerContent": list.elementAt(3),
                    "isCorrect": list.elementAt(3) == rightAns ? true : false,
                    "status": 1
                  }
                ],
              }) +
              "]");

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    Get.snackbar('Thông báo', 'Nhập thành công',
        duration: Duration(seconds: 4),
        animationDuration: Duration(milliseconds: 800),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white);
    return 'Success';
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    Get.snackbar('Thông báo', 'Nhập thất bại',
        duration: Duration(seconds: 4),
        animationDuration: Duration(milliseconds: 800),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white);
    throw Exception(response.statusCode);
  }
}

Future<String> createQuestionVi(
    String title,
    String creator,
    int difficult,
    String rightAns,
    String as1,
    String as2,
    String as3,
    String questionDescription,
    String questionHint) async {
  var list = [rightAns, as1, as2, as3];
  list = list..shuffle();

  final response =
      await http.post(Uri.parse('https://api.wimln.ml/api/Question'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + constant.key,
          },
          body: "[" +
              jsonEncode(<String, dynamic>{
                "questionContent": title,
                "difficulty": difficult,
                "creator": "",
                "questionDescription": questionDescription,
                "questionHint": questionHint,
                "videoUrl": constant.image,
                "status": 1,
                "answers": [
                  {
                    "answerContent": list.first,
                    "isCorrect": list.first == rightAns ? true : false,
                    "status": 1
                  },
                  {
                    "answerContent": list.elementAt(1),
                    "isCorrect": list.elementAt(1) == rightAns ? true : false,
                    "status": 1
                  },
                  {
                    "answerContent": list.elementAt(2),
                    "isCorrect": list.elementAt(2) == rightAns ? true : false,
                    "status": 1
                  },
                  {
                    "answerContent": list.elementAt(3),
                    "isCorrect": list.elementAt(3) == rightAns ? true : false,
                    "status": 1
                  }
                ],
              }) +
              "]");

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    Get.snackbar('Thông báo', 'Nhập thành công',
        duration: Duration(seconds: 4),
        animationDuration: Duration(milliseconds: 800),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white);
    return 'Success';
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.

    Get.snackbar('Thông báo', 'Nhập thất bại',
        duration: Duration(seconds: 4),
        animationDuration: Duration(milliseconds: 800),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white);
    throw Exception(response.statusCode);
  }
}

Future<String> updateQuestion(
  String qus,
  String title,
  int difficult,
  List id,
  List content,
  String questionHint,
  String questionDescription,
) async {
  final response = await http.put(
      Uri.parse('https://api.wimln.ml/api/Question/' + qus),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + constant.key,
      },
      body: jsonEncode(<String, dynamic>{
        "questionContent": title,
        "difficulty": difficult,
        "questionDescription": questionDescription,
        "questionHint": questionHint,
        "\"" + "answers" + "\"": [
          {
            "answerId": id.first,
            "answerContent": content.first,
            "isCorrect": true
          },
          {"answerId": id[1], "answerContent": content[1], "isCorrect": false},
          {"answerId": id[2], "answerContent": content[2], "isCorrect": false},
          {"answerId": id[3], "answerContent": content[3], "isCorrect": false}
        ],
      }));
  print(jsonEncode(<String, dynamic>{
    "questionContent": title,
    "difficulty": difficult,
    "questionDescription": questionDescription,
    "questionHint": questionHint,
    "answers": [
      {"answerId": id.first, "answerContent": content.first, "isCorrect": true},
      {"answerId": id[1], "answerContent": content[1], "isCorrect": false},
      {"answerId": id[2], "answerContent": content[2], "isCorrect": false},
      {"answerId": id[3], "answerContent": content[3], "isCorrect": false}
    ]
  }));
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    Get.snackbar('Thông báo', 'Nhập thành công',
        duration: Duration(seconds: 4),
        animationDuration: Duration(milliseconds: 800),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white);
    return 'Success';
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    Get.snackbar('Thông báo', 'Nhập thất bại ' + response.statusCode.toString(),
        duration: Duration(seconds: 4),
        animationDuration: Duration(milliseconds: 800),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white);
    throw Exception(response.statusCode);
  }
}
