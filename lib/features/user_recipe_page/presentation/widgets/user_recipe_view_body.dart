import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:food_recipes/core/constants/app_colors.dart';
import 'package:food_recipes/core/widgets/custom_button.dart';
import 'package:food_recipes/core/widgets/custom_text_form_field.dart';
import 'package:food_recipes/features/user_recipe_page/presentation/widgets/user_recipe_photo.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../../../main_models/chef_model.dart';
import '../../../../main_models/recipe_model/recipe_model.dart';
import '../../../user_home/view/widgits/steps_list_view_widget.dart';
import 'package:rate/rate.dart';

class UserRecipeViewBody extends StatelessWidget {
  const UserRecipeViewBody(
      {super.key, required this.recipeModel, required this.chefModel});

  final RecipeModel recipeModel;
  final ChefModel chefModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          UserRecipePhoto(recipePhoto: recipeModel.recipePhoto ?? ''),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  recipeModel.recipeDescription ?? '',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
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
                CustomButton(
                    text: 'Rate This Recipe',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              textAlign: TextAlign.center,
                              'Rate this recipe',
                              style: AppTextStyles.bold18
                                  .copyWith(color: AppColors.secondaryColor),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Rate(
                                  allowHalf: true,
                                  iconSize: 40,
                                  color: AppColors.primaryColor,
                                  initialValue: 3,
                                  onChange: (value) {
                                    print(value);
                                  },
                                ),
                                const SizedBox(height: 8),
                                CustomTextFormField(),
                                const SizedBox(height: 8),
                                CustomButton(
                                  text: 'Submit',
                                  onTap: () {
                                    // TODO: rate recipe here and refactor code
                                  },

                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
              ],
            ),
          )
        ],
      )),
    );
  }
}
