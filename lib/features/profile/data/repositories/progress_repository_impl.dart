import 'package:ezdu/core/errors/failures.dart';
import 'package:ezdu/features/profile/domain/entities/achievement.dart';
import 'package:ezdu/features/profile/domain/entities/progress.dart';
import 'package:ezdu/features/profile/domain/repositories/progress_repository.dart';
import 'package:fpdart/src/either.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  @override
  Future<Either<Failure, Progress>> getUserProgress() async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      final data = Progress(
        totalXP: 4233,
        currentStreak: 27,
        weeklyData: [
          DailyProgress(day: '21/07/25', xp: 32),
          DailyProgress(day: '24/07/25', xp: 58),
        ],
        achievements: [
          Achievement(
            id: 1,
            title: 'First Step',
            description: 'Complete your first lesson',
            xp: 50,
            unlockedAt: DateTime.utc(2025, 1, 1),
          ),
          Achievement(
            id: 2,
            title: 'Quiz Master',
            description: 'Score 100% in a quiz',
            xp: 100,
            unlockedAt: DateTime.utc(2025, 2, 10),
          ),
          Achievement(
            id: 3,
            title: "title",
            description: "description",
            xp: 66,
            unlockedAt: DateTime.utc(2025, 2, 10),
          ),
          Achievement(
            id: 4,
            title: 'Daily Streak',
            description: 'Maintain a 7-day streak',
            xp: 150,
            unlockedAt: DateTime.utc(2025, 3, 5),
          ),
          Achievement(
            id: 5,
            title: 'XP Collector',
            description: 'Earn over 1000 XP total',
            xp: 200,
            unlockedAt: DateTime.utc(2025, 3, 15),
          ),
        ],

      );

      return Right(data);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
