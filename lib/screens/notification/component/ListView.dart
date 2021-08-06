import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'Reminder.dart';
import 'package:mtp_choice_web/constants.dart' as constant;
import 'package:http/http.dart' as http;

class Feedbacks {
  final String? feedbackId, content, created, status;

  Feedbacks({
    this.feedbackId,
    this.content,
    this.created,
    this.status,
  });

  factory Feedbacks.fromJson(Map<String, dynamic> json) {
    return Feedbacks(
      feedbackId: json['feedbackId'],
      content: json['content'],
      created: json['created'],
      status: json['status'],
    );
  }
}

class Reminder {
  final String? userId;
  final List<Feedbacks>? fed;
  Reminder({
    this.userId,
    this.fed,
  });
  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      userId: json['userId'],
      fed: json['feedbacks'] != null
          ? json['feedbacks']
              .map<Feedbacks>((data) => Feedbacks.fromJson(data))
              .toList()
          : null,
    );
  }
}

class Remind {
  final String? userId, content, created, feedbackId;
  Remind({this.userId, this.content, this.created, this.feedbackId});
}

Future<List<Reminder>> fetchFeedback(String orderBy, String page) async {
  String quesUrl = '';

  if (orderBy != '') {
    quesUrl = 'https://api.wimln.ml/api/Feedback?excludeRemoved=false';
  } else {
    quesUrl = 'https://api.wimln.ml/api/Feedback?pageNumber=' +
        page +
        '&pageSize=5&excludeRemoved=true';
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

    return jsonResponse.map((data) => new Reminder.fromJson(data)).toList();
  } else {
    // If   the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load feedback');
  }
}

Future<String> removeFeed(String fed) async {
  String url = 'https://api.wimln.ml/api/Feedback/remove';
  final response = await http.put(
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
    Get.snackbar('Tình trạng', 'Xóa thành công',
        duration: Duration(seconds: 4),
        animationDuration: Duration(milliseconds: 800),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white);
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

class RemindersList extends StatefulWidget {
  const RemindersList({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

int page = 0;

class _MyAppState extends State<RemindersList> {
  late Future<List<Reminder>> futureAlbum;

  @override
  void initState() {
    super.initState();
    page = 1;
    futureAlbum = fetchFeedback(constant.order, page.toString());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reminder>>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Reminder>? remind = snapshot.data;
            print("page" + page.toString());
            print("page length" + remind!.length.toString());

            List<Remind>? rem = [];
            for (Reminder re in remind!) {
              if (re.fed != null) {
                for (Feedbacks fe in re.fed!) {
                  rem!.add(
                    Remind(
                        feedbackId: fe.feedbackId,
                        userId: re.userId,
                        content: fe.content,
                        created: fe.created),
                  );
                }
              }
            }
            if (page > 1 && rem!.length == 0) {
              return SizedBox(
                width: double.infinity, // <-- match_parent
                child: ElevatedButton(
                    child: Text('Trang trước',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                    ),
                    onPressed: () async {
                      setState(() {
                        page--;
                        futureAlbum =
                            fetchFeedback(constant.order, page.toString());
                      });
                    }),
              );
            } else {
              return ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 5.0,
                      color: Colors.blueAccent,
                    );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: rem!.length == 0 ? 0 : rem!.length,
                  itemBuilder: (context, index) {
                    final item = rem![index];
                    return ListTile(
                        hoverColor: Colors.blueAccent,
                        title: Row(
                          children: [
                            Icon(
                              Icons.person_outline_rounded,
                              color: Colors.white54,
                              size: 30,
                            ),
                            Text(item.userId!),
                            Spacer(),
                            ElevatedButton(
                                child: Text('Xóa feedback',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blueAccent,
                                ),
                                onPressed: () async {
                                  removeFeed(item.feedbackId!)
                                      .then((result) async {
                                    if (result.contains('Success')) {
                                      setState(() {
                                        rem = [];
                                        futureAlbum = fetchFeedback(
                                            constant.order, page.toString());
                                      });
                                    }
                                  }).catchError((error) {
                                    Get.snackbar(
                                        'Alert', 'Nhập thất bại' + error,
                                        duration: Duration(seconds: 4),
                                        animationDuration:
                                            Duration(milliseconds: 800),
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor: Colors.white);
                                  });
                                }),
                          ],
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Nội dung: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  )),
                              Text(
                                item.content == null ? '' : item.content!,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                              Text(
                                item.created == null ? '' : item.created!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              (index == rem!.length - 1)
                                  ? SizedBox(
                                      width:
                                          double.infinity, // <-- match_parent
                                      child: Row(children: [
                                        ElevatedButton(
                                            child: Text('Trang trước',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white)),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.blueAccent,
                                            ),
                                            onPressed: () async {
                                              setState(() {
                                                if (page == 1) {
                                                  page = 1;
                                                } else {
                                                  page--;
                                                }
                                                futureAlbum = fetchFeedback(
                                                    constant.order,
                                                    page.toString());
                                              });
                                            }),
                                        Spacer(),
                                        ElevatedButton(
                                            child: Text('Trang sau',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white)),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.blueAccent,
                                            ),
                                            onPressed: () async {
                                              setState(() {
                                                page++;
                                                futureAlbum = fetchFeedback(
                                                    constant.order,
                                                    page.toString());
                                              });
                                            })
                                      ]))
                                  : Text(''),
                            ]));
                  });
            }
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        });
  }
}
