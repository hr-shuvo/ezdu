import 'package:ezdu/core/errors/failures.dart';
import 'package:ezdu/features/auth/domain/entities/user.dart';
import 'package:ezdu/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository{
  @override
  Future<Either<Failure, User>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> register(String name, String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }

}