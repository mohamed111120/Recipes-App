part of 'favorites_list_cubit.dart';

@immutable
sealed class FavoritesListState {}

final class FavoritesListInitial extends FavoritesListState {}
final class GetUserFavoritesList extends FavoritesListState {}
