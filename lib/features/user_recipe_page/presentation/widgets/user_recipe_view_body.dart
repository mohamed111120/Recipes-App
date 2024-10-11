import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/constants/app_colors.dart';
import 'package:food_recipes/core/constants/shared_keys.dart';
import 'package:food_recipes/core/services/cache/shered_manager.dart';
import 'package:food_recipes/core/services/register_service.dart';
import 'package:food_recipes/core/widgets/custom_button.dart';
import 'package:food_recipes/core/widgets/custom_text_form_field.dart';
import 'package:food_recipes/features/user_home/manager/user_home_cubit/user_home_cubit.dart';
import 'package:food_recipes/features/user_recipe_page/manager/favorits_cubit/favorits_cubit.dart';
import 'package:food_recipes/features/user_recipe_page/manager/recipe_reviews_cubit/recipe_reviews_cubit.dart';
import 'package:food_recipes/features/user_recipe_page/presentation/widgets/rate_recipe_button.dart';
import 'package:food_recipes/features/user_recipe_page/presentation/widgets/reviews_stream_builder.dart';
import 'package:food_recipes/features/user_recipe_page/presentation/widgets/user_recipe_photo.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_reviews.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../main_models/chef_model.dart';
import '../../../../main_models/recipe_model/recipe_model.dart';
import '../../../user_home/view/widgits/steps_list_view_widget.dart';
import 'package:rate/rate.dart';

import '../../manager/rate_recipe_cubit/rate_recipe_cubit.dart';
import 'favorit_button.dart';

class UserRecipeViewBody extends StatelessWidget {
  const UserRecipeViewBody(
      {super.key, required this.recipeModel, required this.chefModel});

  final RecipeModel recipeModel;
  final ChefModel chefModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(builder: (context) {
        return SingleChildScrollView(
            child: Column(
          children: [
            UserRecipePhoto(recipePhoto: recipeModel.recipePhoto ?? ''),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  Row(
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          recipeModel.recipeDescription ?? '',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      BlocProvider(
                        create: (context) => FavoritsCubit(
                          databaseService: getIt.get<DatabaseService>(),
                        )..isRecipeFavourite(
                            userId: SharedService.get(key: SharedKeys.uid),
                            recipeId: recipeModel.recipeId!),
                        child: FavoritButton(
                          recipeId:  recipeModel.recipeId!,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'What is The Benefits of ${recipeModel.recipeName}',
                    style: AppTextStyles.bold18
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    recipeModel.features ?? 'No features added',
                    style: const TextStyle(
                      color: Colors.black38,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  StepsListViewWidget(
                    recipeModel: recipeModel,
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                      text: 'Lit\'s Use Ore Timer To Cook', onTap: () {}),
                  const SizedBox(height: 24),
                  RateRecipeButton(recipeModel: recipeModel),
                  const SizedBox(height: 24),
                  BlocProvider(
                    create: (context) => RecipeReviewsCubit(
                        databaseService: getIt.get<DatabaseService>()),
                    child: ReviewsStreamBuilder(
                      recipeModel: recipeModel,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
      }),
    );
  }
}
