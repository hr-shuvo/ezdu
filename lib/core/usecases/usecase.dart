import 'package:fpdart/fpdart.dart';

import '../errors/failures.dart';

abstract class UseCase<SuccessType, Params> {
  Future<Either<Failure,SuccessType>> call(Params? params);
}

class NoParams{}