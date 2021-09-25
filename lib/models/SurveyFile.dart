import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/DTO/SurveyDTO.dart';
import 'package:mtp_choice_web/constants.dart' as constant;
import 'package:http/http.dart' as http;

Future<Survey> fetchSurvey() async {
  final response = await http.get(
    Uri.parse('https://api.wimln.ml/api/Game/khao-sat'),
    headers: <String, String>{
      'Content-Type': 'application/json ; charset=UTF-8',
      'Authorization': 'Bearer ' + constant.key,
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return Survey.fromJson(json.decode(response.body));
  } else {
    // If   the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<List<Survey>> fetchSurAll(String questId) async {
  // int page, String orderBy,
  String quesUrl = '';

  if (questId != '') {
    quesUrl = 'https://api.wimln.ml/api/Game/khao-sat?gameIds=' + questId;
  }
  // orderBy = '';
  // } else if (orderBy == 'first page') {
  //   quesUrl =
  //       'https://api.wimln.ml/api/Question?IsAscending=true&PageNumber=1&PageSize=4';
  //   constant.order = '';
  // }
  else {
    quesUrl = 'https://api.wimln.ml/api/Game/khao-sat';
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
    return jsonResponse.map((data) => new Survey.fromJson(data)).toList();
  } else {
    // If   the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load User');
  }
}

Future<String> removeSurvey(String fed) async {
  String url = 'https://api.wimln.ml/api/Game/khao-sat';
  final response = await http.delete(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json ; charset=UTF-8',
      'accept': 'text/plain',
      'Authorization': 'Bearer ' + constant.key,
    },
    body: "[\"" + fed + "\"]",
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return "Success";
  } else {
    // If   the server did not return a 200 OK response,
    // then throw an exception.
    Get.snackbar('Tình trạng', 'Xóa thất bại',
        duration: Duration(seconds: 4),
        animationDuration: Duration(milliseconds: 800),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white);
    return response.statusCode.toString();
  }
}

Future<String> postSurvey(
    String des, String start, String end, List ques, List ans) async {
  final response = await http.post(
      Uri.parse('https://api.wimln.ml/api/Game/khao-sat'),
      headers: <String, String>{
        'Content-Type': 'application/json ; charset=UTF-8',
        'Authorization': 'Bearer ' + constant.key,
      },
      body: jsonEncode(<String, dynamic>{
        "description": des,
        "startTime": start,
        "endTime": end,
        "questions": [
          for (int i = 0; i < ques.length; i++)
            {
              "questionContent": ques[i],
              "answers": [
                for (int an = 0; an < 8; an++)
                  if (ans[i + an + 7 * i] != null ||
                      ans[i + an + 7 * i].toString().trim().isEmpty == false)
                    {
                      "answerContent": ans[i + an + 7 * i],
                    },
              ]
            },
        ],
      }));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Get.snackbar('Thông báo', 'Nhập thành công',
        duration: Duration(seconds: 4),
        animationDuration: Duration(milliseconds: 800),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white);
    return 'Success';
  } else {
    Get.snackbar('Thông báo', 'Nhập thất bại ' + response.statusCode.toString(),
        duration: Duration(seconds: 4),
        animationDuration: Duration(milliseconds: 800),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white);

    // If   the server did not return a 200 OK response,
    // then throw an exception.
    return response.statusCode.toString();
  }
}
