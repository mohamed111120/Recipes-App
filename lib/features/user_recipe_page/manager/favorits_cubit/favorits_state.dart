part of 'favorits_cubit.dart';

@immutable
sealed class FavoritsState {}

final class FavoritsInitial extends FavoritsState {}

final class AddedToFavorite extends FavoritsState {}
final class RemoverToFavorite extends FavoritsState {}
final class IsFavoriteOrNot extends FavoritsState {}
