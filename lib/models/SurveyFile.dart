import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  // jsonEncode(<String, dynamic>{
  //   "name": name,
  //   "description": des,
  //   "startTime": start,
  //   "endTime": end,
  //   "questions": [
  //     {
  //       "questionContent": ques[0],
  //       "answers": [
  //         {
  //           "answerContent": ans[0],
  //         },
  //         {
  //           "answerContent": ans[1],
  //         },
  //         {
  //           "answerContent": ans[2],
  //         },
  //         {
  //           "answerContent": ans[3],
  //         }
  //       ]
  //     },
  //     {
  //       "questionContent": ques[1],
  //       "answers": [
  //         {
  //           "answerContent": ans[4],
  //         },
  //         {
  //           "answerContent": ans[5],
  //         },
  //         {
  //           "answerContent": ans[6],
  //         },
  //         {
  //           "answerContent": ans[7],
  //         }
  //       ]
  //     },
  //     {
  //       "questionContent": ques[2],
  //       "answers": [
  //         {
  //           "answerContent": ans[8],
  //         },
  //         {
  //           "answerContent": ans[9],
  //         },
  //         {
  //           "answerContent": ans[10],
  //         },
  //         {
  //           "answerContent": ans[11],
  //         }
  //       ]
  //     },
  //     {
  //       "questionContent": ques[3],
  //       "answers": [
  //         {
  //           "answerContent": ans[12],
  //         },
  //         {
  //           "answerContent": ans[13],
  //         },
  //         {
  //           "answerContent": ans[14],
  //         },
  //         {
  //           "answerContent": ans[15],
  //         }
  //       ]
  //     },
  //     {
  //       "questionContent": ques[4],
  //       "answers": [
  //         {
  //           "answerContent": ans[16],
  //         },
  //         {
  //           "answerContent": ans[17],
  //         },
  //         {
  //           "answerContent": ans[18],
  //         },
  //         {
  //           "answerContent": ans[19],
  //         }
  //       ]
  //     }
  //   ],
  // }
  final response =
      await http.post(Uri.parse('https://api.wimln.ml/api/Game/khao-sat'),
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
                    for (int an = 0; an < 4; an++)
                      if (ans[i + an + 3 * i] != null ||
                          ans[i + an + 3 * i]
                                  .toString()
                                  .replaceAll(' ', '')
                                  .isEmpty ==
                              false)
                        {
                          "answerContent": ans[i + an + 3 * i],
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

class Answers {
  final String? answerContent, answerId;
  final double? answerPercent;
  Answers({this.answerPercent, this.answerContent, this.answerId});

  factory Answers.fromJson(Map<String, dynamic> json) {
    return Answers(
        answerPercent: json['answerPercent'],
        answerContent: json['answerContent'],
        answerId: json['answerId']);
  }
}

class Questions {
  final String? questionId, questionContent;

  final List<Answers>? answe;
  Questions({
    this.questionId,
    this.questionContent,
    this.answe,
  });

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      questionId: json['questionId'],
      questionContent: json['questionContent'],
      answe: json['answers'] != null
          ? json['answers']
              .map<Answers>((data) => Answers.fromJson(data))
              .toList()
          : null,
    );
  }
}

class Survey {
  final String? gameId, description, startTime, endTime;
  final List<Questions>? qus;
  Survey(
      {this.gameId, this.description, this.startTime, this.endTime, this.qus});

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      gameId: json['gameId'],
      description: json['description'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      qus: json['questions'] != null
          ? json['questions']
              .map<Questions>((data) => Questions.fromJson(data))
              .toList()
          : null,
    );
  }
}

// List demoRecentFiles = [
//   RecentFile(
//     title: "XD File",
//     date: "01-03-2021",
//     score: "1000",
//   ),
//   RecentFile(
//     title: "Figma File",
//     date: "27-02-2021",
//     score: "2000",
//   ),
//   RecentFile(
//     title: "Documetns",
//     date: "23-02-2021",
//     score: "100",
//   ),
//   RecentFile(
//     title: "Sound File",
//     date: "21-02-2021",
//     score: "500",
//   ),
//   RecentFile(
//     title: "Media File",
//     date: "23-02-2021",
//     score: "600",
//   ),
//   RecentFile(
//     title: "Sals PDF",
//     date: "25-02-2021",
//     score: "200",
//   ),
//   RecentFile(
//     title: "Excel File",
//     date: "25-02-2021",
//     score: "700",
//   ),
//   RecentFile(
//     title: "Excel File",
//     date: "25-02-2021",
//     score: "700",
//   ),
//   RecentFile(
//     title: "Excel File",
//     date: "25-02-2021",
//     score: "700",
//   ),
//   RecentFile(
//     title: "Excel File",
//     date: "25-02-2021",
//     score: "700",
//   ),
//   RecentFile(
//     title: "Excel File",
//     date: "25-02-2021",
//     score: "700",
//   ),
//   RecentFile(
//     title: "Excel File",
//     date: "25-02-2021",
//     score: "700",
//   ),
//   RecentFile(
//     title: "Excel File",
//     date: "25-02-2021",
//     score: "700",
//   ),
//   RecentFile(
//     title: "Excel File",
//     date: "25-02-2021",
//     score: "700",
//   ),
//   RecentFile(
//     title: "Excel File",
//     date: "25-02-2021",
//     score: "700",
//   ),
//   RecentFile(
//     title: "Excel File",
//     date: "25-02-2021",
//     score: "700",
//   ),
//   RecentFile(
//     title: "Excel File",
//     date: "25-02-2021",
//     score: "700",
//   ),
//   RecentFile(
//     title: "Excel File",
//     date: "25-02-2021",
//     score: "700",
//   ),
//   RecentFile(
//     title: "Excel File",
//     date: "25-02-2021",
//     score: "700",
//   ),
//   RecentFile(
//     title: "Excel File",
//     date: "25-02-2021",
//     score: "700",
//   ),
// ];
