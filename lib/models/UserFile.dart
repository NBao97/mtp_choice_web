import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<RecentFile>> fetchUser() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new RecentFile.fromJson(data)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load User');
  }
}

class RecentFile {
  final String? title, date, score;

  RecentFile({this.title, this.date, this.score});
  factory RecentFile.fromJson(Map<String, dynamic> json) {
    return RecentFile(
      title: json['title'],
      date: json['date'],
      score: json['score'],
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
