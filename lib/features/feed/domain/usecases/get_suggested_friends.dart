import 'package:ezdu/core/errors/failures.dart';
import 'package:ezdu/core/usecases/usecase.dart';
import 'package:ezdu/features/feed/domain/repositories/feed_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetSuggestedFriends
    implements UseCase<List<Map<String, dynamic>>, NoParams> {
  final FeedRepository repository;

  GetSuggestedFriends(this.repository);

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> call(
    NoParams? params,
  ) async {
    return await repository.getSuggestedFriends();
  }
}
