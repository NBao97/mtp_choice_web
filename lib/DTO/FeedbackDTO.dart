class Feedbacks {
  final String? feedbackId, content, created, status, imageUrl;

  Feedbacks({
    this.feedbackId,
    this.content,
    this.imageUrl,
    this.created,
    this.status,
  });

  factory Feedbacks.fromJson(Map<String, dynamic> json) {
    return Feedbacks(
      feedbackId: json['feedbackId'],
      content: json['content'],
      imageUrl: json['imageUrl'],
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
  final String? userId, content, created, feedbackId, imageUrl;
  Remind(
      {this.userId,
      this.content,
      this.created,
      this.feedbackId,
      this.imageUrl});
}
