import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/constants/shared_keys.dart';
import 'package:food_recipes/core/services/cache/shered_manager.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_model.dart';
import 'package:meta/meta.dart';

import '../../../../main_models/chef_model.dart';

part 'favorites_list_state.dart';

class FavoritesListCubit extends Cubit<FavoritesListState> {
  FavoritesListCubit({
    required this.databaseService,
  }) : super(FavoritesListInitial());

  static FavoritesListCubit get(context) => BlocProvider.of(context);
  final DatabaseService databaseService;
  List<RecipeModel> favoritesRecipesList = [];

  Future<void> getUserFavoritesList() async {
    List<String>? favoritesIdList = await databaseService.getFavoritesRecipes(
      userId: SharedService.get(key: SharedKeys.uid),
    );

    await getRecipes(favoritesIdList);
  }

  Future<void> getRecipes(List<String>? favoritesIdList) async {
    for (var element in favoritesIdList!) {
      RecipeModel? recipe = await databaseService.getRecipe(recipeId: element);
      if (recipe == null) {
        await databaseService.deleteFromFavorites(recipeId: element);
      }
      if (recipe != null) {
        favoritesRecipesList.add(recipe);
      }
    }
    emit(GetUserFavoritesList());
  }

  Future<DocumentSnapshot<ChefModel?>> getChef({required String chefId}) {
    return databaseService.getChef(chefId);
  }

  Future<void> updateRecipeCount({required String recipeId}) async {
    await databaseService.updateRecipeCount(recipeId);
  }
}
