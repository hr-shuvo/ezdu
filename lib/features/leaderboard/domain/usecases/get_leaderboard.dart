import 'package:ezdu/core/errors/failures.dart';
import 'package:ezdu/core/usecases/usecase.dart';
import 'package:ezdu/features/leaderboard/domain/entities/leaderboard.dart';
import 'package:ezdu/features/leaderboard/domain/repositories/leaderboard_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetLeaderboard implements UseCase<LeaderboardData, NoParams> {
  final LeaderboardRepository repository;

  GetLeaderboard(this.repository);

  @override
  Future<Either<Failure, LeaderboardData>> call(NoParams? params) async {
    return await repository.getLeaderboard();
  }
}
