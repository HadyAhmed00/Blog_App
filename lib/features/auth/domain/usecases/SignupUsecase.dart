import 'package:blog/core/error/exceptions.dart';
import 'package:blog/core/error/failurs.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/core/entities/user_entitie.dart';
import 'package:blog/features/auth/domain/repository/repository.dart';
import 'package:fpdart/src/either.dart';


class SignupUsecase implements Usecase<User, SignupPrams> {
  DomainAuthRepo authRepo;

  SignupUsecase(this.authRepo);

  @override
  Future<Either<Failure, User>> call(SignupPrams prams) async {
    return await authRepo.signUpWithEmailAndPassword(
      name: prams.name,
      email: prams.email,
      password: prams.password,
    );
  }
}

class SignupPrams {
  final String name;
  final String email;
  final String password;

  SignupPrams({
    required this.name,
    required this.email,
    required this.password,
  });
}
