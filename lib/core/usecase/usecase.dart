import 'package:blog/core/error/failurs.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<Type, Prams> {
  Future<Either<Failure, Type>> call(Prams prams);
}
class Noparams {
}
