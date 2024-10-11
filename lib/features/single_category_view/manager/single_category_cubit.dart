import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/main_models/chef_model.dart';
import 'package:meta/meta.dart';

import '../../../main_models/recipe_model/recipe_model.dart';

part 'single_category_state.dart';

class SingleCategoryCubit extends Cubit<SingleCategoryState> {
  SingleCategoryCubit({
    required this.databaseService,
  }) : super(SingleCategoryInitial());

  static SingleCategoryCubit get(context) => BlocProvider.of(context);
  final DatabaseService databaseService;
  List<RecipeModel> recipesCategory = [];

  Future<List<RecipeModel>> getRecipesByCategory(
      {required String category}) async {
    emit(SingleCategoryRecipesLoading());
    recipesCategory = [];
    try {
      var recipes = await databaseService.getRecipesByCategory(category);
      for (var element in recipes.docs) {
        recipesCategory.add(element.data());
      }
      emit(SingleCategoryRecipesSuccess());
      return recipesCategory;
    } catch (e) {
      emit(SingleCategoryRecipesError());
      throw Exception(e);
    }
  }

 Future<ChefModel> getChef({required String chefId}) async {
    var chef = await databaseService.getChef(chefId);
    return chef.data()!;
  }

  Future<void> updateRecipeCount ({required String recipeId}) async {
    await databaseService.updateRecipeCount(recipeId);
  }
}
