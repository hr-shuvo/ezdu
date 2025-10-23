import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:ezdu/core/usecases/usecase.dart';
import 'package:ezdu/features/profile/domain/entities/profile.dart';
import 'package:ezdu/features/profile/domain/entities/progress.dart';
import 'package:ezdu/features/profile/domain/usecases/get_user_profile.dart';
import 'package:ezdu/features/profile/domain/usecases/get_user_progress.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  const LoadProfile();
}

class LoadProgress extends ProfileEvent {
  const LoadProgress();
}

// States
class ProfileState extends Equatable {
  final Profile? profile;
  final Progress? progress;
  final bool isProfileLoading;
  final bool isProgressLoading;
  final String? error;

  const ProfileState({
    this.profile,
    this.progress,
    this.isProfileLoading = false,
    this.isProgressLoading = false,
    this.error,
  });

  ProfileState copyWith({
    Profile? profile,
    Progress? progress,
    bool? isProfileLoading,
    bool? isProgressLoading,
    String? error,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      progress: progress ?? this.progress,
      isProfileLoading: isProfileLoading ?? this.isProfileLoading,
      isProgressLoading: isProgressLoading ?? this.isProgressLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    profile,
    progress,
    isProfileLoading,
    isProgressLoading,
    error,
  ];
}

// Bloc
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfile getUserProfile;
  final GetUserProgress getUserProgress;

  ProfileBloc({required this.getUserProfile, required this.getUserProgress})
    : super(const ProfileState()) {
    on<LoadProfile>(_onLoadProfile);
    on<LoadProgress>(_onLoadProgress);
  }

  FutureOr<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isProfileLoading: true, error: null));

    final result = await getUserProfile(NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(error: failure.toString(), isProfileLoading: false),
      ),
      (data) => emit(state.copyWith(profile: data, isProfileLoading: false)),
    );
  }

  FutureOr<void> _onLoadProgress(
    LoadProgress event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isProgressLoading: true, error: null));

    final result = await getUserProgress(NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(error: failure.toString(), isProgressLoading: false),
      ),
      (data) => emit(state.copyWith(progress: data, isProgressLoading: false)),
    );
  }
}
