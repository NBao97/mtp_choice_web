import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/constants.dart' as constant;
import 'package:http/http.dart' as http;

Future<Users> fetchUser() async {
  final response = await http.get(
    Uri.parse('https://api.wimln.ml/api/User'),
    headers: <String, String>{
      'Content-Type': 'application/json ; charset=UTF-8',
      'Authorization': 'Bearer ' + constant.key,
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return Users.fromJson(json.decode(response.body));
  } else {
    // If   the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<List<Users>> fetchUserAll(String questId) async {
  // int page, String orderBy,
  String quesUrl = '';
  if (questId != '') {
    quesUrl = 'https://api.wimln.ml/api/User/many?userIds=' + questId;
  }
  // orderBy = '';
  // } else if (orderBy == 'first page') {
  //   quesUrl =
  //       'https://api.wimln.ml/api/Question?IsAscending=true&PageNumber=1&PageSize=4';
  //   constant.order = '';
  // }
  else {
    quesUrl =
        'https://api.wimln.ml/api/User/many?OrderBy=userRole&PageNumber=0&PageSize=0';
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

    return jsonResponse.map((data) => new Users.fromJson(data)).toList();
  } else {
    // If   the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load User');
  }
}

Future<String> patchUser(
    String userId, String phone, String password, String fullname) async {
  final response = await http.patch(
    Uri.parse('https://api.wimln.ml/api/User'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + constant.key,
    },
    body: jsonEncode(<String, String>{
      "userId": userId,
      "phone": phone,
      "password": password,
      "fullname": fullname,
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    Get.snackbar('Alert', 'Nhập thành công',
        duration: Duration(seconds: 4),
        animationDuration: Duration(milliseconds: 800),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white);
    return 'Success';
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update album.');
  }
}

class Game {
  final String? gameDescription;

  Game({
    this.gameDescription,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      gameDescription: json['gameDescription'],
    );
  }
}

class Histories {
  final String? historyId, session, timeFinished, date;

  final int? score, totalQuestion, numOfCorrect, status;
  final Game? game;
  Histories({
    this.historyId,
    this.session,
    this.timeFinished,
    this.date,
    this.score,
    this.totalQuestion,
    this.numOfCorrect,
    this.status,
    this.game,
  });

  factory Histories.fromJson(Map<String, dynamic> json) {
    return Histories(
      historyId: json['historyId'],
      session: json['session'],
      timeFinished: json['timeFinished'],
      date: json['date'],
      score: json['score'],
      totalQuestion: json['totalQuestion'],
      numOfCorrect: json['numOfCorrect'],
      status: json['status'],
      game: json['game'] != null
          ? json['game'].map<Game>((data) => Game.fromJson(data))
          : null,
    );
  }
}

class Users {
  final String? userId,
      phone,
      password,
      fullname,
      image,
      email,
      deviceId,
      userRole;
  final int? userStatus, bonusPoint;
  final List<Histories>? his;
  Users(
      {this.userId,
      this.phone,
      this.password,
      this.fullname,
      this.image,
      this.bonusPoint,
      this.userStatus,
      this.deviceId,
      this.email,
      this.userRole,
      this.his});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      userId: json['userId'],
      phone: json['phone'],
      password: json['password'],
      fullname: json['fullname'],
      email: json['email'],
      image: json['image'],
      bonusPoint: json['bonusPoint'],
      userStatus: json['userStatus'],
      his: json['histories'] != null
          ? json['histories']
              .map<Histories>((data) => Histories.fromJson(data))
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
