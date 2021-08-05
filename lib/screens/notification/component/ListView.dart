import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  final String? userId, content, created;
  Remind({this.userId, this.content, this.created});
}

Future<List<Reminder>> fetchFeedback(String orderBy) async {
  String quesUrl = '';

  if (orderBy != '') {
    quesUrl = 'https://api.wimln.ml/api/Feedback?excludeRemoved=false';
  } else {
    quesUrl = 'https://api.wimln.ml/api/Feedback?excludeRemoved=true';
  }

  final response = await http.get(
    Uri.parse('https://api.wimln.ml/api/Feedback?excludeRemoved=true'),
    headers: <String, String>{
      'Content-Type': 'application/json ; charset=UTF-8',
      'Authorization': 'Bearer ' + constant.key,
    },
  );
  print(response.statusCode.toString());
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

class RemindersList extends StatefulWidget {
  const RemindersList({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<RemindersList> {
  late Future<List<Reminder>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchFeedback(constant.order);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reminder>>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Reminder>? remind = snapshot.data;
            List<Remind>? rem = [];
            for (Reminder re in remind!) {
              if (re.fed != null) {
                for (Feedbacks fe in re.fed!) {
                  rem.add(
                    Remind(
                        userId: re.userId,
                        content: fe.content,
                        created: fe.created),
                  );
                }
              }
            }
            return ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: rem.length,
                itemBuilder: (context, index) {
                  final item = rem[index];
                  return ListTile(
                      hoverColor: Colors.blueAccent,
                      title: Row(
                        children: [
                          Icon(
                            Icons.person_outline_rounded,
                            color: Colors.white54,
                            size: 30,
                          ),
                          Text(item.userId!)
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
                          ]));
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        });
  }
}
