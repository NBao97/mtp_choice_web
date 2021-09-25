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
      creatorUserId,
      videoUrl;
  final int? difficulty, version;
  final List<Answers>? ans;
  QuestionFile(
      {this.questionContent,
      this.questionHint,
      this.version,
      this.creatorUserId,
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
      creator: json['creator'],
      creatorUserId: json['creatorUserId'],
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
