import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/main_models/chef_model.dart';
import 'package:meta/meta.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/services/database_service.dart';
import '../../../core/services/media_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../main_models/recipe_model/recipe_model.dart';

part 'chef_recipes_state.dart';

class ChefRecipesCubit extends Cubit<ChefRecipesState> {
  ChefRecipesCubit({
    required this.databaseService,
    required this.authService,
    required this.storageService,
    required this.mediaService,
  }) : super(ChefRecipesInitial());

  static ChefRecipesCubit get(context) => BlocProvider.of(context);
  final DatabaseService databaseService;
  final AuthService authService;
  final StorageService storageService;
  final MediaService mediaService;

  ChefModel? currentChef;

  Future<void> getChefProfileData() async {
    await databaseService.getChef(authService.uid ?? '').then(
      (value) {
        currentChef = value.data();
      },
    );
    emit(GetCurrentChefProfileData());
  }

  Future<QuerySnapshot<RecipeModel?>> getChefRecipes() {
    return databaseService.getChefRecipes(currentChef?.uid ?? '');
  }


  Future<void> deleteRecipe({required String recipeId}) async {
    try {
      await databaseService.deleteRecipe(recipeId: recipeId);
      await getChefRecipes();
      emit(DeleteRecipeSuccess());
    } catch (e) {
      emit(DeleteRecipeError());
    }
  }

}
