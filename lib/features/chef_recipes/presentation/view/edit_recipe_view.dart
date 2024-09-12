import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/core/services/register_service.dart';
import 'package:food_recipes/features/chef_recipes/presentation/widgets/edit_recipe_view_body.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/media_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../main_models/recipe_model/recipe_model.dart';
import '../../manger/chef_recipes_cubit.dart';
class EditRecipeView extends StatelessWidget {
  const EditRecipeView({super.key, required this.recipeModel});

  final RecipeModel recipeModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChefRecipesCubit(
        databaseService: getIt.get<DatabaseService>(),
        authService: getIt.get<AuthService>(),
        storageService: getIt.get<StorageService>(),
        mediaService: getIt.get<MediaService>(),
      ),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              recipeModel.recipeName ?? '',
              style: AppTextStyles.bold18.copyWith(color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  ChefRecipesCubit.get(context)
                      .deleteRecipe(recipeId: recipeModel.recipeId!)
                      .then(
                    (value) {
                      Navigator.pop(context);
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          body: EditRecipeViewBody(
            recipeModel: recipeModel,
          ),
        );
      }),
    );
  }
}
