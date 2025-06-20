import 'package:blog/features/auth/domain/entities/user_entitie.dart';
import 'package:fpdart/fpdart.dart';
import 'package:blog/core/error/failurs.dart';

abstract interface class DomainAuthRepo {
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}
