import 'package:ezdu/core/errors/failures.dart' show Failure;
import 'package:ezdu/core/usecases/usecase.dart';
import 'package:ezdu/features/profile/domain/entities/progress.dart';
import 'package:ezdu/features/profile/domain/repositories/progress_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetUserProgress implements UseCase<Progress, NoParams> {
  final ProgressRepository repository;

  GetUserProgress(this.repository);

  @override
  Future<Either<Failure, Progress>> call(NoParams? params) async {
    return await repository.getUserProgress();
  }
}