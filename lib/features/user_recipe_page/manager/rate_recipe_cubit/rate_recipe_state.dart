part of 'rate_recipe_cubit.dart';

@immutable
sealed class RateRecipeState {}

final class UserRecipeInitial extends RateRecipeState {}
final class UserRecipeRatedSuccess extends RateRecipeState {}
final class UserRecipeRatedError extends RateRecipeState {}
