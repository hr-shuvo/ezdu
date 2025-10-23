import 'package:ezdu/core/errors/failures.dart';
import 'package:ezdu/features/feed/entities/feed.dart';
import 'package:fpdart/src/either.dart';

class FeedRepositoryImpl {
  @override
  Future<Either<Failure, List<FeedEntry>>> getFeedItems() async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final data = [
        FeedEntry(
          id: '1',
          type: 'achievement',
          userName: 'Sarah Chen',
          avatar: '👩‍🦰',
          action: 'reached a 30-day streak!',
          timestamp: '2 hours ago',
          language: '🇪🇸 Spanish',
          likeCount: 24,
          isLiked: false,
        ),
        FeedEntry(
          id: '2',
          type: 'sentence_share',
          userName: 'Alex Rodriguez',
          avatar: '👨‍💼',
          action: 'shared a sentence',
          sentence: 'El gato está durmiendo en el sofá',
          translation: 'The cat is sleeping on the sofa',
          timestamp: '4 hours ago',
          language: '🇫🇷 French',
          likeCount: 42,
          isLiked: false,
        ),
        FeedEntry(
          id: '3',
          type: 'friend_suggestions_slider',
          likeCount: 0,
          isLiked: false,
        ),
        FeedEntry(
          id: '4',
          type: 'single_friend',
          userName: 'Jordan Lee',
          avatar: '👩‍🎓',
          language: '🇯🇵 Japanese',
          mutualFriends: 3,
          likeCount: 0,
          isLiked: false,
        ),
        FeedEntry(
          id: '5',
          type: 'notification',
          title: 'Daily Practice Reminder',
          message: "You haven't practiced today. Keep your streak alive!",
          timestamp: '1 hour ago',
          likeCount: 0,
          isLiked: false,
        ),
        FeedEntry(
          id: '6',
          type: 'achievement',
          userName: 'Marcus Thompson',
          avatar: '👨‍🎯',
          action: 'is now in 2nd place in Gold League!',
          timestamp: '3 hours ago',
          language: '🇩🇪 German',
          likeCount: 56,
          isLiked: false,
        ),
        FeedEntry(
          id: '7',
          type: 'announcement',
          title: '🎉 New Challenge Available',
          message: 'Try the new Monthly Challenge and earn special rewards!',
          timestamp: '6 hours ago',
          likeCount: 0,
          isLiked: false,
        ),
        FeedEntry(
          id: '8',
          type: 'achievement',
          userName: 'Emma Wilson',
          avatar: '👩‍🔬',
          action: 'completed 1,000 XP this week!',
          timestamp: '7 hours ago',
          language: '🇮🇹 Italian',
          likeCount: 38,
          isLiked: false,
        ),
      ];

      return Right(data);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>>
  getSuggestedFriends() async {
    try {
      final data = [
        {
          'id': 'f1',
          'name': 'Jordan Lee',
          'avatar': '👩‍🎓',
          'friends': 3,
          'language': '🇯🇵 Japanese',
        },
        {
          'id': 'f2',
          'name': 'David Kim',
          'avatar': '👨‍💻',
          'friends': 5,
          'language': '🇰🇷 Korean',
        },
        {
          'id': 'f3',
          'name': 'Sofia Martinez',
          'avatar': '👩‍🎨',
          'friends': 4,
          'language': '🇪🇸 Spanish',
        },
        {
          'id': 'f4',
          'name': 'Lucas Chen',
          'avatar': '👨‍🏫',
          'friends': 2,
          'language': '🇨🇳 Mandarin',
        },
        {
          'id': 'f5',
          'name': 'Anna Mueller',
          'avatar': '👩‍⚕️',
          'friends': 6,
          'language': '🇩🇪 German',
        },
      ];

      return Right(data);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
