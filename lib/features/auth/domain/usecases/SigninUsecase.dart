import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failurs.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/entities/user_entitie.dart';
import '../repository/repository.dart';

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
