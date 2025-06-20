import 'package:blog/features/auth/domain/entities/user_entitie.dart';
import 'package:blog/features/auth/domain/usecases/SignupUsecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUsecase _signupUsecase;

  AuthBloc({required SignupUsecase signupUsecase})
    : _signupUsecase = signupUsecase,
      super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final res = await _signupUsecase(
        SignupPrams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );
      res.fold((l) => emit(AuthFailed(l.massage)),
               (r) => emit(AuthSuccess(r))
      );
    });
  }
}
