
import 'package:blog/core/error/failurs.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/auth/domain/repository/repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/entities/user_entitie.dart';

class CurrentUser implements Usecase<User,Noparams>{

  DomainAuthRepo authRepo;

  CurrentUser(this.authRepo);

  @override
  Future<Either<Failure, User>> call(Noparams prams) async{

    return await authRepo.getCurrentUser();

  }

}


