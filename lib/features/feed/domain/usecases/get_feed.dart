import 'package:ezdu/core/errors/failures.dart';
import 'package:ezdu/core/usecases/usecase.dart';
import 'package:ezdu/features/feed/domain/entities/feed.dart';
import 'package:ezdu/features/feed/domain/repositories/feed_repository.dart';
import 'package:fpdart/src/either.dart';

class GetFeedItems implements UseCase<List<FeedEntry>, NoParams> {
  final FeedRepository repository;

  GetFeedItems(this.repository);

  @override
  Future<Either<Failure, List<FeedEntry>>> call(NoParams? params) async {
    return await repository.getFeedItems();
  }
}
