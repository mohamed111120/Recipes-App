import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/core/services/register_service.dart';
import 'package:food_recipes/features/chef_recipes/presentation/widgets/edit_recipe_view_body.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/media_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../main_models/recipe_model/recipe_model.dart';
import '../../manger/chef_recipes_cubit.dart';
import 'chef_recipes_view.dart';

class EditRecipeView extends StatelessWidget {
  const EditRecipeView({super.key, required this.recipeModel});

  final RecipeModel recipeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipeModel.recipeName ?? '',
          style: AppTextStyles.bold18.copyWith(color: Colors.black),
        ),
        actions: [
          BlocBuilder<ChefRecipesCubit, ChefRecipesState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: const Text('Are you sure you want to delete?'),
                          actions: [
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    text: 'No',
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomButton(
                                    text: 'Yes',
                                    onTap: () {
                                      ChefRecipesCubit.get(context)
                                          .deleteRecipe(
                                              recipeId: recipeModel.recipeId!)
                                          .then((value) {
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ]);
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red,
                ),
              );
            },
          ),
        ],
      ),
      body: EditRecipeViewBody(
        recipeModel: recipeModel,
      ),
    );
  }
}
