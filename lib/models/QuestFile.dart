import 'dart:convert';
import 'package:get/get_connect/http/src/http/utils/body_decoder.dart';
import 'package:mtp_choice_web/constants.dart' as constant;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class Question {
  final String questionContent;
  final int difficulty;
  final String creator;

  Question({
    required this.questionContent,
    required this.difficulty,
    required this.creator,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionContent: json['questionContent'],
      difficulty: json['difficulty'],
      creator: json['creator'],
    );
  }
}

Future<String> createQuestion(String title, String creator, String difficult,
    String rightAns, String as1, String as2, String as3) async {
  var list = [rightAns, as1, as2, as3];
  list = list..shuffle();
  final response =
      await http.post(Uri.parse('https://api.wimln.ml/api/Question'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + constant.key,
          },
          body: jsonEncode(<String, dynamic>{
            "questionContent": title,
            "difficulty": int.parse(difficult),
            "creator": "Nguyen Hoang Ngoc Bao",
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
          }));
  print(list);
  print(list.first == rightAns ? true : false);
  print(list.elementAt(3));
  print(list.elementAt(2));

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    Get.snackbar(
      'Alert',
      'Nhập thành công',
      duration: Duration(seconds: 4),
      animationDuration: Duration(milliseconds: 800),
      snackPosition: SnackPosition.TOP,
    );
    return 'Success';
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print(response.body);
    Get.snackbar(
      'Alert',
      'Nhập thất bại',
      duration: Duration(seconds: 4),
      animationDuration: Duration(milliseconds: 800),
      snackPosition: SnackPosition.TOP,
    );
    throw Exception(response.statusCode);
  }
}
