import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/DTO/UserDTO.dart';
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
    constant.id = Users.fromJson(json.decode(response.body)).userRole!;
    constant.imageU = Users.fromJson(json.decode(response.body)).image!;
    constant.userName = Users.fromJson(json.decode(response.body)).fullname!;
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
    quesUrl = 'https://api.wimln.ml/api/User/many?userIds=' +
        questId +
        '&includeHistory=true';
  } else if (constant.order == "top100") {
    quesUrl =
        "https://api.wimln.ml/api/User/many?OrderBy=bonusPoint&IsAscending=false&PageNumber=1&PageSize=100";
  }
  // orderBy = '';
  // } else if (orderBy == 'first page') {
  //   quesUrl =
  //       'https://api.wimln.ml/api/Question?IsAscending=true&PageNumber=1&PageSize=4';
  //   constant.order = '';
  // }
  else {
    quesUrl = 'https://api.wimln.ml/api/User/many';
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
    constant.order = "";
    return jsonResponse.map((data) => new Users.fromJson(data)).toList();
  } else {
    // If   the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load User');
  }
}

Future<String> patchUser(String userId, String phone, String email,
    String password, String fullname, String image) async {
  final response = await http.put(
    Uri.parse('https://api.wimln.ml/api/User'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + constant.key,
    },
    body: jsonEncode(<String, String>{
      "userId": userId,
      "email": email,
      "phone": phone,
      "image": image,
      "password": password,
      "fullname": fullname,
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    constant.imageU = image;
    constant.userName = fullname;
    Get.snackbar('Thông báo', 'Nhập thành công',
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
