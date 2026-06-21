import 'package:dartz/dartz.dart';
import 'package:liveewire_products/core/error/failures.dart';

abstract class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
