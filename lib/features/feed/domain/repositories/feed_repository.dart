import 'package:ezdu/core/errors/failures.dart';
import 'package:ezdu/features/feed/domain/entities/feed.dart';
import 'package:fpdart/fpdart.dart';

abstract class FeedRepository {
  Future<Either<Failure, List<FeedEntry>>> getFeedItems();

  Future<Either<Failure, List<Map<String, dynamic>>>> getSuggestedFriends();
}
