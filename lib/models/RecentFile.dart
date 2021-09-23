import 'dart:async';
import 'dart:convert';
import 'package:mtp_choice_web/constants.dart' as constant;
import 'package:http/http.dart' as http;

Future<List<QuestionFile>> fetchQuestion(
    int page, String orderBy, String questId) async {
  String quesUrl = '';

  if (questId != '') {
    quesUrl = 'https://api.wimln.ml/api/Question?questionIds=' + questId;

    orderBy = '';
  } else if (questId == '' && orderBy == 'first page') {
    quesUrl =
        'https://api.wimln.ml/api/Question?OrderBy=created&IsAscending=false&PageNumber=1&PageSize=4';
    constant.order = '';
  } else if (constant.search != "") {
    quesUrl =
        'https://api.wimln.ml/api/Question?OrderBy=created&questionContentSearch=' +
            constant.search +
            '&IsAscending=false&PageNumber=' +
            page.toString() +
            '&PageSize=1000';
  } else {
    quesUrl =
        'https://api.wimln.ml/api/Question?OrderBy=created&IsAscending=true&PageNumber=' +
            page.toString() +
            '&PageSize=1000';
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
    print(quesUrl);
    return jsonResponse.map((data) => new QuestionFile.fromJson(data)).toList();
  } else {
    // If   the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load question');
  }
}

class Answers {
  final String? answerId, questionId, answerContent;
  final bool? isCorrect;

  Answers({
    this.answerId,
    this.questionId,
    this.answerContent,
    this.isCorrect,
  });

  factory Answers.fromJson(Map<String, dynamic> json) {
    return Answers(
      answerId: json['answerId'],
      questionId: json['questionId'],
      answerContent: json['answerContent'],
      isCorrect: json['isCorrect'],
    );
  }
}

class QuestionFile {
  final String? questionContent,
      creator,
      questionId,
      status,
      questionHint,
      questionDescription,
      imageUrl,
      videoUrl;
  final int? difficulty, version;
  final List<Answers>? ans;
  QuestionFile(
      {this.questionContent,
      this.questionHint,
      this.version,
      this.questionDescription,
      this.difficulty,
      this.creator,
      this.questionId,
      this.imageUrl,
      this.ans,
      this.videoUrl,
      this.status});

  factory QuestionFile.fromJson(Map<String, dynamic> json) {
    return QuestionFile(
      questionContent: json['questionContent'],
      difficulty: json['difficulty'],
      creator: json['creatorUserId'],
      questionId: json['questionId'],
      status: json['status'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      version: json['version'],
      questionDescription: json['questionDescription'],
      questionHint: json['questionHint'],
      ans: json['answers'] != null
          ? json['answers']
              .map<Answers>((data) => Answers.fromJson(data))
              .toList()
          : null,
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
