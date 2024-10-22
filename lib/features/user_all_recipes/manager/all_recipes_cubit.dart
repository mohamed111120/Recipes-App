import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/main_models/chef_model.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_model.dart';
import 'package:meta/meta.dart';

import '../../../core/services/database_service.dart';

part 'all_recipes_state.dart';

class AllRecipesCubit extends Cubit<AllRecipesState> {
  AllRecipesCubit({
   required this.databaseService,
  }) : super(AllRecipesInitial());
  static AllRecipesCubit get(context) => BlocProvider.of(context);
  final DatabaseService databaseService;
  List<RecipeModel> allRecipes = [];
  getAllRecipes() async {
   var result =  await databaseService.getAllRecipes();
    for (var element in result) {
      allRecipes.add(element.data());
    }

    emit(AllRecipesDone());
  }
 Future<ChefModel> getChef({required String uid}) async{
    DocumentSnapshot<ChefModel?> chefModel = await databaseService.getChef (uid);
   return chefModel.data()!;
  }
}
