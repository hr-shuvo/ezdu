import 'package:ezdu/core/errors/failures.dart';
import 'package:ezdu/features/leaderboard/domain/entities/leaderboard.dart';
import 'package:fpdart/fpdart.dart';

abstract class LeaderboardRepository {
  Future<Either<Failure, LeaderboardData>> getLeaderboard();
}
