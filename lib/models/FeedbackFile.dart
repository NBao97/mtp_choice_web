import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mtp_choice_web/DTO/FeedbackDTO.dart';
import 'package:mtp_choice_web/constants.dart' as constant;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

Future<List<Reminder>> fetchFeedback() async {
  String quesUrl = '';

  quesUrl = 'https://api.wimln.ml/api/Feedback?excludeRemoved=true';

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

    return jsonResponse.map((data) => new Reminder.fromJson(data)).toList();
  } else {
    // If   the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load feedback');
  }
}

Future<String> removeFeed(String fed) async {
  String url = 'https://api.wimln.ml/api/Feedback/remove';
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
