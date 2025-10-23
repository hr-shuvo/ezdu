import 'package:ezdu/core/errors/failures.dart';
import 'package:ezdu/features/leaderboard/domain/entities/leaderboard.dart';
import 'package:ezdu/features/leaderboard/domain/repositories/leaderboard_repository.dart';
import 'package:fpdart/src/either.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  @override
  Future<Either<Failure, LeaderboardData>> getLeaderboard() async {
    // TODO: implement getLeaderboard
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      // Dummy leaderboard entries
      final todayEntries = [
        LeaderboardEntry(
          userId: 1,
          userName: 'Shuvo',
          xp: 120,
          streak: 5,
          imageUrl: null,
        ),
        LeaderboardEntry(
          userId: 2,
          userName: 'Nadia',
          xp: 110,
          streak: 4,
          imageUrl: null,
        ),
        LeaderboardEntry(
          userId: 3,
          userName: 'Rahim',
          xp: 100,
          streak: 3,
          imageUrl: null,
        ),
      ];

      final weeklyEntries = [
        LeaderboardEntry(
          userId: 4,
          userName: 'Sadia',
          xp: 600,
          streak: 10,
          imageUrl: null,
        ),
        LeaderboardEntry(
          userId: 5,
          userName: 'Kamal',
          xp: 580,
          streak: 8,
          imageUrl: null,
        ),
        LeaderboardEntry(
          userId: 6,
          userName: 'Amin',
          xp: 560,
          streak: 9,
          imageUrl: null,
        ),
      ];

      final allTimeEntries = [
        LeaderboardEntry(
          userId: 7,
          userName: 'Bashir',
          xp: 8000,
          streak: 50,
          imageUrl: null,
        ),
        LeaderboardEntry(
          userId: 8,
          userName: 'Tina',
          xp: 7800,
          streak: 48,
          imageUrl: null,
        ),
        LeaderboardEntry(
          userId: 9,
          userName: 'Shuvo',
          xp: 7700,
          streak: 47,
          imageUrl: null,
        ),
        LeaderboardEntry(
          userId: 5,
          userName: 'Kamal',
          xp: 580,
          streak: 8,
          imageUrl: null,
        ),
        LeaderboardEntry(
          userId: 6,
          userName: 'Amin',
          xp: 560,
          streak: 9,
          imageUrl: null,
        ),
      ];

      final data = LeaderboardData(
        todayEntries: todayEntries,
        weeklyEntries: weeklyEntries,
        allTimeEntries: allTimeEntries,
      );

      return Right(data);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
