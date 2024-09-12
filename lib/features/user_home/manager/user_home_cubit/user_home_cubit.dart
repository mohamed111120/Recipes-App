import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/auth_service.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/main_models/chef_model.dart';
import 'package:food_recipes/main_models/user_model.dart';
import 'package:meta/meta.dart';

import '../../../../main_models/recipe_model/recipe_model.dart';

part 'user_home_state.dart';

class UserHomeCubit extends Cubit<UserHomeState> {
  UserHomeCubit({required this.databaseService, required this.authService})
      : super(UserHomeInitial());

  static UserHomeCubit get(context) => BlocProvider.of(context);
  final DatabaseService databaseService;
  final AuthService authService;
  var recipes = [];
  UserModel? currentUser;

  Future<void> getCurrentUser() async {
    currentUser = await databaseService.getCurrentUser(authService.uid!);
    emit( GetCurrentUser());
  }

  Stream<QuerySnapshot<RecipeModel>> getFeaturedRecipes() {
    try {
      return databaseService.getFeaturedRecipes();
    } on Exception catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot<RecipeModel?>>? getPopularRecipes () {
    try {
      return databaseService.getPopularRecipes();
    } on Exception catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot<ChefModel?>> getRecipeChef({required String chefId}) {
    return databaseService.getSingleChefs(chefId);
  }
  Future<DocumentSnapshot<ChefModel?>> getChef ({required String chefId})  {
    return databaseService.getChef(chefId);
  }
  Future<void> updateRecipeCount ({required String recipeId}) async {
    await databaseService.updateRecipeCount(recipeId);
  }
}
