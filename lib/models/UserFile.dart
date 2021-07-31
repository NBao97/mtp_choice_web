import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/constants.dart' as constant;
import 'package:http/http.dart' as http;

Future<User> fetchUser() async {
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

    return User.fromJson(json.decode(response.body));
  } else {
    // If   the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
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
      "userId": "baonhnse62490@fpt.edu.vn",
      "phone": phone,
      "password": password,
      "fullname": fullname,
    }),
  );
  print(response.body);
  print(jsonEncode(<String, String>{
    "userId": "baonhnse62490@fpt.edu.vn",
    "email": 'baonhnse62490@fpt.edu.vn',
    "phone": phone,
    "password": password,
    "fullname": fullname,
  }));
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

class User {
  final String? userId, phone, password, fullname, image;

  User({this.userId, this.phone, this.password, this.fullname, this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      phone: json['phone'],
      password: json['password'],
      fullname: json['fullname'],
      image: json['image'],
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
