import 'package:ezdu/core/errors/failures.dart';
import 'package:ezdu/features/profile/domain/entities/progress.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProgressRepository {
  Future<Either<Failure, Progress>> getUserProgress();
}