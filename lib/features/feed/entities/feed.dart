import 'package:equatable/equatable.dart';

class FeedEntry extends Equatable {
  final String id;
  final String type;
  final String? userName;
  final String? avatar;
  final String? action;
  final String? timestamp;
  final String? language;
  final int likeCount;
  final bool isLiked;
  final String? sentence;
  final String? translation;
  final String? title;
  final String? message;
  final int? mutualFriends;

  const FeedEntry({
    required this.id,
    required this.type,
    this.userName,
    this.avatar,
    this.action,
    this.timestamp,
    this.language,
    required this.likeCount,
    required this.isLiked,
    this.sentence,
    this.translation,
    this.title,
    this.message,
    this.mutualFriends,
  });

  FeedEntry copyWith({
    String? id,
    String? type,
    String? userName,
    String? avatar,
    String? action,
    String? timestamp,
    String? language,
    int? likeCount,
    bool? isLiked,
    String? sentence,
    String? translation,
    String? title,
    String? message,
    int? mutualFriends,
  }) {
    return FeedEntry(
      id: id ?? this.id,
      type: type ?? this.type,
      userName: userName ?? this.userName,
      avatar: avatar ?? this.avatar,
      action: action ?? this.action,
      timestamp: timestamp ?? this.timestamp,
      language: language ?? this.language,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      sentence: sentence ?? this.sentence,
      translation: translation ?? this.translation,
      title: title ?? this.title,
      message: message ?? this.message,
      mutualFriends: mutualFriends ?? this.mutualFriends,
    );
  }

  @override
  List<Object?> get props => [
    id,
    type,
    userName,
    avatar,
    action,
    timestamp,
    language,
    likeCount,
    isLiked,
    sentence,
    translation,
    title,
    message,
    mutualFriends,
  ];
}
