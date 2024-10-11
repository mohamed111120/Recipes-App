import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/services/database_service.dart';

part 'favorits_state.dart';

class FavoritsCubit extends Cubit<FavoritsState> {
  FavoritsCubit({required this.databaseService}) : super(FavoritsInitial());
  static FavoritsCubit get(context) => BlocProvider.of(context);
  final DatabaseService databaseService;
  bool isFavorite = false;

  addToFavorite({required String userId, required String recipeId}) async {




    await databaseService.addToFavourites(
      userId: userId,
      recipeId: recipeId,
    );
    isFavorite = true;
    emit(AddedToFavorite());
  }

  removeFromFavorite({required String userId, required String recipeId}) async {
    await databaseService.deleteFromFavourites(
      userId: userId,
      recipeId: recipeId,
    );
    isFavorite = false;
    emit(RemoverToFavorite());
  }

  isRecipeFavourite({required String userId, required String recipeId}) async {
    isFavorite = await databaseService.isRecipeFavourite(
      userId: userId,
      recipeId: recipeId,
    ) ?? false;
    emit(IsFavoriteOrNot());
  }
}
