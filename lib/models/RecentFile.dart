import 'dart:async';
import 'dart:convert';
import 'package:mtp_choice_web/constants.dart' as constant;
import 'package:http/http.dart' as http;

Future<List<QuestionFile>> fetchQuestion(
    int page, String orderBy, String questId) async {
  String quesUrl = '';
  if (questId != '') {
    quesUrl = 'https://api.wimln.ml/api/Question?questionIds=' + questId;
    constant.questId = '';
  } else {
    quesUrl =
        'https://api.wimln.ml/api/Question?OrderBy=difficulty&IsAscending=true&PageNumber=' +
            page.toString() +
            '&PageSize=10';
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
    print(page);
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new QuestionFile.fromJson(data)).toList();
  } else {
    // If   the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class QuestionFile {
  final String? questionContent, creator, questionId;
  final int? difficulty;
  QuestionFile(
      {this.questionContent, this.difficulty, this.creator, this.questionId});

  factory QuestionFile.fromJson(Map<String, dynamic> json) {
    return QuestionFile(
      questionContent: json['questionContent'],
      difficulty: json['difficulty'],
      creator: json['creator'],
      questionId: json['questionId'],
    );
  }
}

class RecentFile {
  final String? type, title, date, author;

  RecentFile({this.type, this.title, this.date, this.author});

  factory RecentFile.fromJson(Map<String, dynamic> json) {
    return RecentFile(
      type: json['type'],
      title: json['title'],
      date: json['date'],
      author: json['author'],
    );
  }
}

List demoRecentFiles = [
  RecentFile(
    type: "icons/xd_file.svg",
    title: "XD File",
    date: "01-03-2021",
    author: "Nguyễn văn A",
  ),
  RecentFile(
    type: "icons/Figma_file.svg",
    title: "Figma File",
    date: "27-02-2021",
    author: "Nguyễn văn A",
  ),
  RecentFile(
    type: "icons/doc_file.svg",
    title: "Documetns",
    date: "23-02-2021",
    author: "Nguyễn văn A",
  ),
  RecentFile(
    type: "icons/sound_file.svg",
    title: "Sound File",
    date: "21-02-2021",
    author: "Nguyễn văn A",
  ),
  RecentFile(
    type: "icons/media_file.svg",
    title: "Media File",
    date: "23-02-2021",
    author: "Dương thị D",
  ),
  RecentFile(
    type: "icons/pdf_file.svg",
    title: "Sals PDF",
    date: "25-02-2021",
    author: "Đoàn văn C",
  ),
  RecentFile(
    type: "icons/excle_file.svg",
    title: "Excel File",
    date: "25-02-2021",
    author: "Nguyễn văn B",
  ),
];
