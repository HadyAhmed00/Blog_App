import 'package:blog/features/auth/domain/entities/user_entitie.dart';
import 'package:blog/features/auth/domain/usecases/SignupUsecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUsecase _signupUsecase;
  final SigninUsecase _signinUsecase;

  AuthBloc({
    required SignupUsecase signupUsecase,
    required SigninUsecase signinUsecase,
  }) : _signupUsecase = signupUsecase,
       _signinUsecase = signinUsecase,
       super(AuthInitial()) {
    on<AuthSignUp>(_authSignUp);
    on<AuthSignIn>(_authSignIn);
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
    res.fold((l) => emit(AuthFailed(l.massage)), (r) => emit(AuthSuccess(r)));
  }
  void _authSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _signinUsecase(
      SigninPrams(email: event.email, password: event.password)
    );
    res.fold((l) => emit(AuthFailed(l.massage)), (r) => emit(AuthSuccess(r)));
  }

}
