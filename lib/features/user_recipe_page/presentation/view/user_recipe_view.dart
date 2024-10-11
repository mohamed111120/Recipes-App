import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/core/services/register_service.dart';
import 'package:food_recipes/main_models/chef_model.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_model.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../manager/rate_recipe_cubit/rate_recipe_cubit.dart';
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
