import 'package:blog/core/error/exceptions.dart';
import 'package:blog/core/error/failurs.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/domain/entities/user_entitie.dart';
import 'package:blog/features/auth/domain/repository/repository.dart';
import 'package:fpdart/src/either.dart';

class SigninUsecase implements Usecase<User, SigninPrams> {

  DomainAuthRepo authRepo;

  SigninUsecase(
    this.authRepo,
  );

  Future<Either<Failure, User>> call(SigninPrams prams) async{
    return await authRepo.signInWithEmailAndPassword(email: prams.email, password: prams.password);
  }


}

class SigninPrams {

  final String email;
  final String password;

  SigninPrams({
    required this.email,
    required this.password,
  });


}

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
