import 'package:ezdu/data/datasources/class_remote_ds.dart';
import 'package:ezdu/data/repositories/auth_repository.dart';
import 'package:ezdu/data/repositories/classRepository.dart';
import 'package:ezdu/features/auth/datasources/auth_remote_ds.dart';
import 'package:ezdu/services/dio_client.dart';
import 'package:ezdu/services/storage_service.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<StorageService>(() => StorageService());

  //auth
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      remoteDataSource: sl(),
      storageService: sl(),
      dioClient: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl()),
  );

  // class
  sl.registerLazySingleton<ClassRepository>(
    () => ClassRepository(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ClassRemoteDataSource>(
    () => ClassRemoteDataSource(sl()),
  );

  print('Dependency Injection initialized.');
}
