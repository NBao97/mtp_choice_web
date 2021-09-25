import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mtp_choice_web/DTO/QuestionDTO.dart';

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
) async {
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
                if (constant.image != '') "imageUrl": constant.image,
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
    String questionDescription) async {
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
    String questionDescription,
    String video,
    String image) async {
  print(jsonEncode(<String, dynamic>{
    "questionContent": title,
    "difficulty": difficult,
    "questionDescription": questionDescription,
    if (video != '') "videoUrl": video,
    if (image != '') "imageUrl": image,
    "answers": [
      {"answerId": id.first, "answerContent": content.first, "isCorrect": true},
      for (int i = 1; i < content.length; i++)
        {"answerId": id[i], "answerContent": content[i], "isCorrect": false},
    ],
  }));
  final response =
      await http.put(Uri.parse('https://api.wimln.ml/api/Question/' + qus),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + constant.key,
          },
          body: jsonEncode(<String, dynamic>{
            "questionContent": title,
            "difficulty": difficult,
            "questionDescription": questionDescription,
            if (video != '') "videoUrl": video,
            if (image != '') "imageUrl": image,
            "answers": [
              {
                "answerId": id.first,
                "answerContent": content.first,
                "isCorrect": true
              },
              for (int i = 1; i < content.length; i++)
                {
                  "answerId": id[i],
                  "answerContent": content[i],
                  "isCorrect": false
                },
            ],
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

Future<dynamic> approveQuestion(String til) async {
  String url = '';
  if (til == 'Xóa') {
    url = 'https://api.wimln.ml/api/Question/reject';

    final response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json ; charset=UTF-8',
        'accept': 'text/plain',
        'Authorization': 'Bearer ' + constant.key,
      },
      body: "[\"" + constant.questId + "\"]",
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return "SuccessD";
    } else {
      // If   the server did not return a 200 OK response,
      // then throw an exception.
      return response.statusCode.toString();
    }
  } else {
    url = 'https://api.wimln.ml/api/Question/approve';
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json ; charset=UTF-8',
        'accept': 'text/plain',
        'Authorization': 'Bearer ' + constant.key,
      },
      body: "[\"" + constant.questId + "\"]",
    );
    if (response.statusCode == 200) {
      return "Success";
    } else {
      // If   the server did not return a 200 OK response,
      // then throw an exception.
      return response.statusCode.toString();
    }
  }
}

Future<String> refQuest() async {
  final response = await http.put(
    Uri.parse('https://api.wimln.ml/api/Question/refresh-altp-questions'),
    headers: <String, String>{
      'Content-Type': 'application/json ; charset=UTF-8',
      'Authorization': 'Bearer ' + constant.key,
    },
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return "Success";
  } else {
    // If   the server did not return a 200 OK response,
    // then throw an exception.
    return response.statusCode.toString();
  }
}

Future<List<QuestionFile>> fetchQuestion(
    int page, String orderBy, String questId) async {
  String quesUrl = '';

  if (questId != '') {
    quesUrl = 'https://api.wimln.ml/api/Question?questionIds=' + questId;

    orderBy = '';
  } else if (questId == '' && orderBy == 'first page') {
    quesUrl =
        'https://api.wimln.ml/api/Question?OrderBy=created&IsAscending=false&PageNumber=1&PageSize=4';
    constant.order = '';
  } else if (constant.search != "") {
    quesUrl =
        'https://api.wimln.ml/api/Question?OrderBy=created&questionContentSearch=' +
            constant.search +
            '&IsAscending=false&PageNumber=' +
            page.toString() +
            '&PageSize=1000';
  } else {
    quesUrl =
        'https://api.wimln.ml/api/Question?OrderBy=created&IsAscending=true&PageNumber=' +
            page.toString() +
            '&PageSize=1000';
  }

  final response = await http.get(
    Uri.parse(quesUrl),
    headers: <String, String>{
      'Content-Type': 'application/json ; charset=UTF-8',
      'Authorization': 'Bearer ' + constant.key,
    },
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List jsonResponse = json.decode(response.body);
    print(quesUrl);
    return jsonResponse.map((data) => new QuestionFile.fromJson(data)).toList();
  } else {
    // If   the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load question');
  }
}
