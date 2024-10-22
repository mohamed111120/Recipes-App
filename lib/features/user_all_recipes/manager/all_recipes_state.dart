part of 'all_recipes_cubit.dart';

@immutable
sealed class AllRecipesState {}

final class AllRecipesInitial extends AllRecipesState {}
final class AllRecipesDone extends AllRecipesState {}
