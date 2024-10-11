import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/cache/shered_manager.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/main_models/chef_model.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_reviews.dart';
import 'package:meta/meta.dart';

import '../../../../core/constants/shared_keys.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../main_models/recipe_model/recipe_model.dart';
import '../../../../main_models/user_model.dart';

part 'chef_home_state.dart';

class ChefHomeCubit extends Cubit<ChefHomeState> {
  ChefHomeCubit({
    required this.databaseService,
    required this.authService,
  }) : super(ChefHomeInitial());

  static ChefHomeCubit get(context) => BlocProvider.of(context);
  final DatabaseService databaseService;
  final AuthService authService;
  ChefModel? currentChef;

  List<RecipeReviews> chefReviews = [];
  List<RecipeModel?> recipes = [];

  getChefData() async {
    DocumentSnapshot<ChefModel?> chef = await databaseService.getChef(
      SharedService.get(key: SharedKeys.uid),
    );
    currentChef = chef.data();
  }

  getChefRecipes() async {
    QuerySnapshot<RecipeModel?> chefRecipes = await databaseService
        .getChefRecipes(SharedService.get(key: SharedKeys.uid));
    if (kDebugMode) {
      print('chefRecipes.docs.length ${chefRecipes.docs.length}');
    }

    for (var recipe in chefRecipes.docs) {
      print(recipe.data());
      if (recipe.data()?.recipeReviews != null &&
          recipe.data()?.recipeReviews != []) {
        for (var review in recipe.data()!.recipeReviews!) {
          ;
          chefReviews.add(review);
          recipes.add(recipe.data());
        }
      }
    }
    emit(GetChefDataState());
  }

  Future<DocumentSnapshot<UserModel?>> getUser({required String userId}) async {
    return databaseService.getUser(
      userId,
    );
  }
}
