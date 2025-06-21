part of 'user_login_cubit.dart';

@immutable
sealed class UserLoginState {}

final class UserLoginInitial extends UserLoginState {}

final class UserIsLoggedIn extends UserLoginState{
  final User user;
  UserIsLoggedIn(this.user);
}
