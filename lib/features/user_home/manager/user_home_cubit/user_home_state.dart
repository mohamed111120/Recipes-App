part of 'user_home_cubit.dart';

@immutable
sealed class UserHomeState {}

final class UserHomeInitial extends UserHomeState {}
final class GetAllRecipesLoading extends UserHomeState {}
final class GetAllRecipesSuccess extends UserHomeState {}
final class GetAllRecipesError extends UserHomeState {}
final class GetCurrentUser extends UserHomeState {}
