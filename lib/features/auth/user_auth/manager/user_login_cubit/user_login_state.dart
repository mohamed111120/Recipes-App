part of 'user_login_cubit.dart';

@immutable
sealed class UserLoginState {}

final class UserLoginInitial extends UserLoginState {}
final class UserLoginLoading extends UserLoginState {}
final class UserLoginSuccess extends UserLoginState {}
final class UserLoginError extends UserLoginState {
  final String error;
  UserLoginError({required this.error});
}
