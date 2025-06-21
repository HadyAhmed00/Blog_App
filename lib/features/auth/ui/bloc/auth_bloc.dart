import 'dart:async';

import 'package:blog/core/common/cubits/user_login/user_login_cubit.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/core/entities/user_entitie.dart';
import 'package:blog/features/auth/domain/usecases/SignupUsecase.dart';
import 'package:blog/features/auth/domain/usecases/currunt_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/SigninUsecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUsecase _signupUsecase;
  final SigninUsecase _signinUsecase;
  final CurrentUser _currentUser;
  final UserLoginCubit _userLoginCubits;

  AuthBloc({
    required SignupUsecase signupUsecase,
    required SigninUsecase signinUsecase,
    required CurrentUser currentUser,
    required UserLoginCubit userLoginCubit
  }) : _signupUsecase = signupUsecase,
       _signinUsecase = signinUsecase,
       _currentUser = currentUser,
       _userLoginCubits = userLoginCubit,
       super(AuthInitial()) {
    on<AuthEvent>((_,emit)=> emit(AuthLoading()));
    on<AuthSignUp>(_authSignUp);
    on<AuthSignIn>(_authSignIn);
    on<AuthIsUserLoggedIn>(_authIsUserLoggedIn);
  }

  void _authSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _signupUsecase(
      SignupPrams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold((l) => emit(AuthFailed(l.massage)), (r) => _emitSuccess(r,emit));
  }

  void _authSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _signinUsecase(
      SigninPrams(email: event.email, password: event.password),
    );
    res.fold((l) => emit(AuthFailed(l.massage)), (r) => _emitSuccess(r,emit));
  }

  void _authIsUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(Noparams());
    res.fold((l) => emit(AuthFailed(l.massage)), (r) => _emitSuccess(r,emit));
  }

  void _emitSuccess(User user, Emitter<AuthState> emit){

    _userLoginCubits.updateUser(user);
    emit(AuthSuccess(user));

  }
}
