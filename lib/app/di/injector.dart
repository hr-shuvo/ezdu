import 'package:ezdu/data/datasources/class_remote_ds.dart';
import 'package:ezdu/data/datasources/lesson_remote_ds.dart';
import 'package:ezdu/data/datasources/question_remote_ds.dart';
import 'package:ezdu/data/datasources/quiz_remote_ds.dart';
import 'package:ezdu/data/datasources/subject_remote_ds.dart';
import 'package:ezdu/data/datasources/user_progress_ds.dart';
import 'package:ezdu/data/repositories/archive_repository.dart';
import 'package:ezdu/data/repositories/auth_repository.dart';
import 'package:ezdu/data/repositories/classRepository.dart';
import 'package:ezdu/data/repositories/lesson_repository.dart';
import 'package:ezdu/data/repositories/question_repository.dart';
import 'package:ezdu/data/repositories/quiz_repository.dart';
import 'package:ezdu/data/repositories/subject_repository.dart';
import 'package:ezdu/data/repositories/user_progress_repository.dart';
import 'package:ezdu/features/archive/datasources/archive_remote_ds.dart';
import 'package:ezdu/features/auth/datasources/auth_remote_ds.dart';
import 'package:ezdu/features/play/datasources/play_quiz_remote_ds.dart';
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

  // subject
  sl.registerLazySingleton<SubjectRepository>(
    () => SubjectRepository(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<SubjectRemoteDataSource>(
    () => SubjectRemoteDataSource(sl()),
  );

  // lesson
  sl.registerLazySingleton<LessonRepository>(
    () => LessonRepository(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<LessonRemoteDataSource>(
    () => LessonRemoteDataSource(sl()),
  );

  // question
  sl.registerLazySingleton<QuestionRepository>(
        () => QuestionRepository(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<QuestionRemoteDataSource>(
        () => QuestionRemoteDataSource(sl()),
  );

  // archive
  sl.registerLazySingleton<ArchiveRepository>(
    () => ArchiveRepository(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ArchiveRemoteDataSource>(
    () => ArchiveRemoteDataSource(sl()),
  );

  // quiz
  sl.registerLazySingleton<QuizRepository>(
    () => QuizRepository(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<QuizRemoteDataSource>(
    () => QuizRemoteDataSource(sl()),
  );

  // progress
  sl.registerLazySingleton<UserProgressRepository>(
    () => UserProgressRepository(sl(), sl()),
  );
  sl.registerLazySingleton<PlayQuizRemoteDataSource>(
    () => PlayQuizRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<UserProgressRemoteDataSource>(
    () => UserProgressRemoteDataSource(),
  );

  print('Dependency Injection initialized.');
}
