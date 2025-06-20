import 'dart:math';

import 'package:blog/core/error/exceptions.dart';
import 'package:blog/core/error/failurs.dart';
import 'package:blog/features/auth/data/data_source/remote_data_sorce.dart';
import 'package:blog/features/auth/domain/entities/user_entitie.dart';
import 'package:blog/features/auth/domain/repository/repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements DomainAuthRepo {

  final AuthRemoteDataSource dataSource;

  AuthRepositoryImpl({
    required this.dataSource
  });

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {

    try{
      final longedUser = await dataSource.signInWithEmailAndPassword(email: email, password: password  );
      return right(longedUser);
    }catch(e){
      return Either.left(Failure(e.toString()));
    }


  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      var userModel = await dataSource.signUpWithEmailAndPassword(
          name: name, email: email, password: password);
      return right(userModel);
    }on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
