import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:mtp_choice_web/constants.dart' as constant;

import '../../../constants.dart';

Color colorS = Colors.blue;
IconData icon = Icons.check_circle_outline;
final String qusId = constant.questId;

Future<dynamic> approveQuestion() async {
  String url = 'https://api.wimln.ml/api/Question/approve';
  final response = await http.put(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json ; charset=UTF-8',
      'accept': 'text/plain',
      'Authorization': 'Bearer ' + constant.key,
    },
    body: "[" + qusId + "]",
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    refQuest();
    return "Success";
  } else {
    // If   the server did not return a 200 OK response,
    // then throw an exception.
    return response.statusCode.toString();
  }
}

Future<dynamic> arejectQuestion() async {
  String url = 'https://api.wimln.ml/api/Question/reject';
  final response = await http.put(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json ; charset=UTF-8',
      'accept': 'text/plain',
      'Authorization': 'Bearer ' + constant.key,
    },
    body: "[" + qusId + "]",
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    refQuest();
    return "Success";
  } else {
    // If   the server did not return a 200 OK response,
    // then throw an exception.
    return response.statusCode.toString();
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

String til = '';

class StorageInfoCard extends StatelessWidget {
  const StorageInfoCard({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  void checkStatus() {
    if (title == 'APPROVED') {
      til = 'Đã chấp nhận';
      colorS = Colors.blue;
      icon = Icons.check_circle_outline;
    } else if (title == 'NOT_APPROVED') {
      til = 'Chờ duyệt';
      colorS = Colors.yellowAccent;
      icon = Icons.help_outline;
    } else if (title == 'KHAO_SAT_QUESTION') {
      til = 'Câu hỏi khảo sát';
      colorS = Colors.blueAccent;
      icon = Icons.question_answer_outlined;
    } else if (title == 'Xóa') {
      til = 'Xóa';
      colorS = Colors.red;
      icon = Icons.close_outlined;
    } else {
      colorS = Colors.white;
      icon = Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {

    checkStatus();
    return Container(
      margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.15),
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: colorS,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: bgColor,
                    ),
                    onPressed: () async {
                      await approveQuestion().then((value) async {
                        if (value != "") {
                          if (value.contains("Success")) {
                            Get.snackbar(
                                'Thông báo', 'Cập nhật trạng thái thành công',
                                duration: Duration(seconds: 4),
                                animationDuration: Duration(milliseconds: 800),
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.white);
                          } else {
                            Get.snackbar('Thông báo',
                                'Cập nhật trạng thái thất bại' + value,
                                duration: Duration(seconds: 4),
                                animationDuration: Duration(milliseconds: 800),
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.white);
                          }
                        }
                      }).catchError((error) {
                        Get.snackbar(
                            'Thông báo', 'Cập nhật trạng thái thất bại' + error,
                            duration: Duration(seconds: 4),
                            animationDuration: Duration(milliseconds: 800),
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.white);
                      });
                    },
                    child: Text(
                      til,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
