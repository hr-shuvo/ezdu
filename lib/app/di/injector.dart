import 'package:ezdu/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ezdu/features/auth/domain/repositories/auth_repository.dart';
import 'package:ezdu/features/auth/domain/usecases/login_user.dart';
import 'package:ezdu/features/auth/domain/usecases/logout_user.dart';
import 'package:ezdu/features/auth/domain/usecases/register_user.dart';
import 'package:ezdu/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerFactory(
    () => AuthBloc(loginUser: sl(), registerUser: sl(), logoutUser: sl()),
  );

  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());


  print('Dependency Injection initialized.');
}
