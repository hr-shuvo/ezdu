import 'package:ezdu/core/errors/failures.dart';
import 'package:ezdu/features/profile/domain/entities/profile.dart';
import 'package:ezdu/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/src/either.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<Either<Failure, Profile>> getUserProfile() async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      final data = Profile();

      return Right(data);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
