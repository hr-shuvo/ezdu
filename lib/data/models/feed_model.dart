class FeedItem {
  int id;
  String name;
  int userId;
  String userImageUrl;
  int type;
  String message;
  String content;
  bool isRead;
  int likeCount;

  int subjectId;
  String subject;
  String subjectImageUrl;
  int topicId;
  String topic;

  FeedItem({
    required this.id,
    required this.name,
    required this.userId,
    required this.userImageUrl,
    required this.type,
    required this.message,
    required this.content,
    required this.isRead,
    required this.likeCount,
    required this.subjectId,
    required this.subject,
    required this.subjectImageUrl,
    required this.topicId,
    required this.topic,
  });

  factory FeedItem.fromJson(Map<String, dynamic> json) {
    return FeedItem(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      userId: json['userId'] ?? 0,
      userImageUrl: json['userImageUrl'] ?? '',
      type: json['type'] ?? 0,
      message: json['message'] ?? '',
      content: json['content'] ?? '',
      isRead: json['isRead'] ?? false,
      likeCount: json['likeCount'] ?? 0,

      subjectId: json['subjectId'] ?? 0,
      subject: json['subject'] ?? '',
      subjectImageUrl: json['subjectImageUrl'] ?? '',

      topicId: json['topicId'] ?? 0,
      topic: json['topic'] ?? '',
    );
  }
}
