import 'package:bloc/bloc.dart';
import 'package:blog/core/entities/user_entitie.dart';
import 'package:meta/meta.dart';

part 'user_login_state.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit() : super(UserLoginInitial());

  void updateUser(User? user){
    if(user == null){
      emit(UserLoginInitial());
    }else{
      emit(UserIsLoggedIn(user));
    }


  }

}
