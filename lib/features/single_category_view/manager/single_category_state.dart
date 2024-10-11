part of 'single_category_cubit.dart';

@immutable
sealed class SingleCategoryState {}

final class SingleCategoryInitial extends SingleCategoryState {}
final class SingleCategoryRecipesLoading extends SingleCategoryState {}
final class SingleCategoryRecipesSuccess extends SingleCategoryState {}
final class SingleCategoryRecipesError extends SingleCategoryState {}
