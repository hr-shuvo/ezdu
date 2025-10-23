import 'package:equatable/equatable.dart';
import 'package:ezdu/core/usecases/usecase.dart';
import 'package:ezdu/features/leaderboard/domain/entities/leaderboard.dart';
import 'package:ezdu/features/leaderboard/domain/usecases/get_leaderboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadLeaderboard extends LeaderboardEvent {
  const LoadLeaderboard();
}

// States
abstract class LeaderboardState extends Equatable {
  const LeaderboardState();

  @override
  List<Object?> get props => [];
}

class LeaderboardInitial extends LeaderboardState {
  const LeaderboardInitial();
}

class LeaderboardLoading extends LeaderboardState {
  const LeaderboardLoading();
}

class LeaderboardLoaded extends LeaderboardState {
  final List<LeaderboardEntry> todayEntries;
  final List<LeaderboardEntry> weeklyEntries;
  final List<LeaderboardEntry> allTimeEntries;

  const LeaderboardLoaded({
    required this.todayEntries,
    required this.weeklyEntries,
    required this.allTimeEntries,
  });

  @override
  List<Object> get props => [todayEntries, weeklyEntries, todayEntries];
}

class LeaderboardError extends LeaderboardState {
  final String message;

  const LeaderboardError({required this.message});

  @override
  List<Object?> get props => [message];
}

// Bloc
class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final GetLeaderboard getLeaderboard;

  LeaderboardBloc({required this.getLeaderboard})
    : super(LeaderboardInitial()) {
    on<LoadLeaderboard>(_onLoadLeaderboard);
  }

  Future<void> _onLoadLeaderboard(
    LoadLeaderboard event,
    Emitter<LeaderboardState> emit,
  ) async {
    emit(const LeaderboardLoading());

    final result = await getLeaderboard(NoParams());

    result.fold(
      (failure) => emit(LeaderboardError(message: failure.message)),
      (data) => emit(
        LeaderboardLoaded(
          todayEntries: data.todayEntries,
          weeklyEntries: data.weeklyEntries,
          allTimeEntries: data.allTimeEntries,
        ),
      ),
    );
  }
}
