import 'package:ezdu/core/errors/failures.dart';
import 'package:ezdu/features/profile/domain/entities/profile.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getUserProfile();
}
