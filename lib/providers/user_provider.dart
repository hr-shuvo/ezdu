import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/data/repositories/user_progress_repository.dart';
import 'package:ezdu/data/repositories/user_repository.dart';
import 'package:flutter_riverpod/legacy.dart';

class UserState {
  final int streak;
  final int totalXp;
  final int weekXp;
  final int coin;
  final bool isPremium;
  final String? error;

  UserState({
    required this.streak,
    required this.totalXp,
    required this.weekXp,
    required this.coin,
    required this.isPremium,
    required this.error,
  });

  const UserState.initial()
    : streak = 0,
      totalXp = 0,
        weekXp = 0,
      coin = 0,
      isPremium = false,
      error = null;

  UserState copyWithError(String errorMsg) {
    return UserState(
      streak: 0,
      totalXp: 0,
      weekXp: 0,
      coin: 0,
      isPremium: false,
      error: errorMsg,
    );
  }

  UserState copyWith({
    int? streak,
    int? totalXp,
    int? weekXp,
    int? coin,
    bool? isPremium,
    String? error,
  }) {
    return UserState(
      streak: streak ?? this.streak,
      totalXp: totalXp ?? this.totalXp,
      weekXp: weekXp ?? this.weekXp,
      coin: coin ?? this.coin,
      isPremium: isPremium ?? this.isPremium,
      error: error ?? this.error,
    );
  }
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier(this._userRepository, this._progressRepository)
    : super(const UserState.initial());

  final UserRepository _userRepository;
  final UserProgressRepository _progressRepository;

  Future<void> init() async {
    final result = await _progressRepository.getMyProgress();

    if (result.success && result.data != null) {
      state = state.copyWith(
        streak: result.data!.streakCount,
        totalXp: result.data!.totalXp,
        coin: result.data!.coin,
        weekXp: result.data!.weekXp
      );
    } else {
      state = state.copyWithError(result.message ?? "Failed to load progress");
    }
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier(sl(), sl());
});

// final userInitProvider = FutureProvider<void>((ref) async {
//   await ref.read(userProvider.notifier).init();
// });
