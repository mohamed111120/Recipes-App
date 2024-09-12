part of 'chef_recipes_cubit.dart';

@immutable
sealed class ChefRecipesState {}

final class ChefRecipesInitial extends ChefRecipesState {}
final class GetCurrentChefProfileData extends ChefRecipesState {}
final class DeleteRecipeSuccess extends ChefRecipesState {}
final class DeleteRecipeError extends ChefRecipesState {}
