import 'package:ezdu/core/errors/failures.dart';
import 'package:ezdu/core/usecases/usecase.dart';
import 'package:ezdu/features/profile/domain/entities/profile.dart';
import 'package:ezdu/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetUserProfile implements UseCase<Profile, NoParams> {
  final ProfileRepository repository;

  GetUserProfile(this.repository);

  @override
  Future<Either<Failure, Profile>> call(NoParams? params) async {
    return await repository.getUserProfile();
  }
}