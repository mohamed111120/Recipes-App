part of 'chef_recipes_cubit.dart';

@immutable
sealed class ChefRecipesState {}

final class ChefRecipesInitial extends ChefRecipesState {}
final class GetCurrentChefProfileData extends ChefRecipesState {}
final class DeleteRecipeSuccess extends ChefRecipesState {}
final class DeleteRecipeError extends ChefRecipesState {}
final class EditRecipeLoading extends ChefRecipesState {}
final class EditRecipeSuccess extends ChefRecipesState {}
final class EditRecipeError extends ChefRecipesState {}
final class ChangeRecipeCategory extends ChefRecipesState {}
final class AddAnotherStep extends ChefRecipesState {}
final class RemoveLastStep extends ChefRecipesState {}
