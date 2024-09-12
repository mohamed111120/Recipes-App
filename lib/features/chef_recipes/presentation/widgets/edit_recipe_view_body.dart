import 'package:flutter/material.dart';
import 'package:food_recipes/core/constants/app_colors.dart';
import 'package:food_recipes/core/widgets/custom_button.dart';
import 'package:food_recipes/core/widgets/custom_text_form_field.dart';
import 'package:food_recipes/features/chef_add_recipes/view/widgets/custom_add_recipes_minutes_text_form_field.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../../../main_models/recipe_model/recipe_model.dart';

class EditRecipeViewBody extends StatelessWidget {
  const EditRecipeViewBody({super.key, required this.recipeModel});

  final RecipeModel recipeModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Here you can edit',
                  style: AppTextStyles.bold16.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                Text(
                  ' ${recipeModel.recipeName}',
                  style: AppTextStyles.bold16.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  height: 100,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                        recipeModel.recipePhoto ?? '',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    'Click Here to edit your recipe Photo',
                    style: AppTextStyles.bold16.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Name',
                style: AppTextStyles.bold16
                    .copyWith(color: AppColors.secondaryColor)),
            CustomTextFormField(
              hintText: recipeModel.recipeName ?? '',
            ),
            const SizedBox(height: 20),
            Text('description',
                style: AppTextStyles.bold16
                    .copyWith(color: AppColors.secondaryColor)),
            CustomTextFormField(
              hintText: recipeModel.recipeDescription ?? '',
            ),
            const SizedBox(height: 20),
            Text('Steps',
                style: AppTextStyles.bold16
                    .copyWith(color: AppColors.secondaryColor)),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recipeModel.recipeSteps?.length ?? 0,
                itemBuilder: (context, index) {
                  return  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: TextEditingController(),
                          hintText: recipeModel.recipeSteps?[index].step ?? '',
                        ),
                      ),
                      SizedBox(width: 24),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.secondaryColor.withOpacity(.8),
                        ),
                        width: 65,
                        height: 65,
                        child: Center(
                          child: Text(recipeModel.recipeSteps?[index].minutes.toString() ?? '',
                              style: AppTextStyles.bold18
                                  .copyWith(color: Colors.white)),
                          ),
                        ),
                    ],
                  );
                }),
            const SizedBox(height: 20),
            CustomButton(text: 'Edit', onTap: () {}),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
