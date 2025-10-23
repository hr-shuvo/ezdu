import 'package:ezdu/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ezdu/features/auth/domain/repositories/auth_repository.dart';
import 'package:ezdu/features/auth/domain/usecases/login_user.dart';
import 'package:ezdu/features/auth/domain/usecases/logout_user.dart';
import 'package:ezdu/features/auth/domain/usecases/register_user.dart';
import 'package:ezdu/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ezdu/features/leaderboard/data/repositories/leaderboard_repository_impl.dart';
import 'package:ezdu/features/leaderboard/domain/repositories/leaderboard_repository.dart';
import 'package:ezdu/features/leaderboard/domain/usecases/get_leaderboard.dart';
import 'package:ezdu/features/leaderboard/presentation/bloc/leaderboard_bloc.dart';
import 'package:ezdu/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:ezdu/features/profile/data/repositories/progress_repository_impl.dart';
import 'package:ezdu/features/profile/domain/repositories/profile_repository.dart';
import 'package:ezdu/features/profile/domain/repositories/progress_repository.dart';
import 'package:ezdu/features/profile/domain/usecases/get_user_profile.dart';
import 'package:ezdu/features/profile/domain/usecases/get_user_progress.dart';
import 'package:ezdu/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // auth
  sl.registerFactory(
    () => AuthBloc(loginUser: sl(), registerUser: sl(), logoutUser: sl()),
  );
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  // leaderboard
  sl.registerFactory(() => LeaderboardBloc(getLeaderboard: sl()));
  sl.registerLazySingleton(() => GetLeaderboard(sl()));
  sl.registerLazySingleton<LeaderboardRepository>(
    () => LeaderboardRepositoryImpl(),
  );

  // profile | progress
  sl.registerFactory(
    () => ProfileBloc(getUserProfile: sl(), getUserProgress: sl()),
  );
  sl.registerLazySingleton(() => GetUserProfile(sl()));
  sl.registerLazySingleton(() => GetUserProgress(sl()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl());
  sl.registerLazySingleton<ProgressRepository>(() => ProgressRepositoryImpl());

  print('Dependency Injection initialized.');
}
