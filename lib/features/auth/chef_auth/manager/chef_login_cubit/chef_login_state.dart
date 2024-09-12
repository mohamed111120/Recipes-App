part of 'chef_login_cubit.dart';

@immutable
sealed class ChefLoginState {}

final class ChefLoginInitial extends ChefLoginState {}

final class ChefLoginLoading extends ChefLoginState {}

final class ChefLoginSuccess extends ChefLoginState {}

final class ChefLoginError extends ChefLoginState {
  final String error;

  ChefLoginError({required this.error});
}