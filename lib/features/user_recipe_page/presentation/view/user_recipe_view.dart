import 'package:flutter/material.dart';
import 'package:food_recipes/main_models/chef_model.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_model.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../widgets/user_recipe_view_body.dart';

class UserRecipeView extends StatelessWidget {
  const UserRecipeView(
      {super.key, required this.recipeModel, required this.chefModel});

  final RecipeModel recipeModel;
  final ChefModel chefModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipeModel.recipeName ?? '',
          style: AppTextStyles.bold18.copyWith(color: Colors.black),
        ),
      ),
      body: UserRecipeViewBody(
        chefModel: chefModel,
        recipeModel: recipeModel,
      ),
    );
  }
}
