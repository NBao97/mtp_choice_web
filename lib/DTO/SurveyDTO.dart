class Answers {
  final String? answerContent, answerId;
  final double? answerPercent;
  Answers({this.answerPercent, this.answerContent, this.answerId});

  factory Answers.fromJson(Map<String, dynamic> json) {
    return Answers(
        answerPercent: json['answerPercent'],
        answerContent: json['answerContent'],
        answerId: json['answerId']);
  }
}

class Questions {
  final String? questionId, questionContent;

  final List<Answers>? answe;
  Questions({
    this.questionId,
    this.questionContent,
    this.answe,
  });

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      questionId: json['questionId'],
      questionContent: json['questionContent'],
      answe: json['answers'] != null
          ? json['answers']
              .map<Answers>((data) => Answers.fromJson(data))
              .toList()
          : null,
    );
  }
}

class Survey {
  final String? gameId, description, startTime, endTime;
  final List<Questions>? qus;
  Survey(
      {this.gameId, this.description, this.startTime, this.endTime, this.qus});

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      gameId: json['gameId'],
      description: json['description'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      qus: json['questions'] != null
          ? json['questions']
              .map<Questions>((data) => Questions.fromJson(data))
              .toList()
          : null,
    );
  }
}
