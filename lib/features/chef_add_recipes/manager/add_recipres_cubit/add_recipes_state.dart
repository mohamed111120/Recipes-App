part of 'add_recipes_cubit.dart';

@immutable
sealed class AddRecipesState {}

final class AddRecipesInitial extends AddRecipesState {}

final class AddAnotherStep extends AddRecipesState {}

final class RemoveLastStep extends AddRecipesState {}
// Submit Recipes

final class SubmitRecipeLoading extends AddRecipesState {}

final class SubmitRecipeSuccess extends AddRecipesState {}

final class SubmitRecipeError extends AddRecipesState {}

final class UploadRecipeImageLoading extends AddRecipesState {}

final class UploadRecipeImageSuccess extends AddRecipesState {}

final class UploadRecipeImageError extends AddRecipesState {}
final class MakeFeatured extends AddRecipesState {}
final class ChangeRecipeCategory extends AddRecipesState {}
