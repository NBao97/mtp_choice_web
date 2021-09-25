class Histories {
  final String? historyId, session, timeFinished, date;

  final int? score, totalQuestion, numOfCorrect, status;
  final Game? game;
  Histories({
    this.historyId,
    this.session,
    this.timeFinished,
    this.date,
    this.score,
    this.totalQuestion,
    this.numOfCorrect,
    this.status,
    this.game,
  });

  factory Histories.fromJson(Map<String, dynamic> json) {
    return Histories(
      historyId: json['historyId'],
      session: json['session'],
      timeFinished: json['timeFinished'],
      date: json['date'],
      score: json['score'],
      totalQuestion: json['totalQuestion'],
      numOfCorrect: json['numOfCorrect'],
      status: json['status'],
      game: json['game'] != null ? Game.fromJson(json['game']) : null,
    );
  }
}

class Users {
  final String? userId,
      phone,
      password,
      fullname,
      image,
      email,
      deviceId,
      userRole;
  final int? userStatus, bonusPoint;
  final List<Histories>? his;
  Users(
      {this.userId,
      this.phone,
      this.password,
      this.fullname,
      this.image,
      this.bonusPoint,
      this.userStatus,
      this.deviceId,
      this.email,
      this.userRole,
      this.his});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      userId: json['userId'],
      phone: json['phone'],
      password: json['password'],
      fullname: json['fullname'],
      email: json['email'],
      image: json['image'],
      userRole: json['userRole'],
      bonusPoint: json['bonusPoint'],
      userStatus: json['userStatus'],
      his: json['histories'] != null
          ? json['histories']
              .map<Histories>((data) => Histories.fromJson(data))
              .toList()
          : null,
    );
  }
}

class Game {
  final String? gameDescription, gameId, time;
  final int? status;
  Game({
    this.gameDescription,
    this.gameId,
    this.status,
    this.time,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      gameDescription: json['gameDescription'],
      status: json['status'],
      time: json['time'],
      gameId: json['gameId'],
    );
  }
}
