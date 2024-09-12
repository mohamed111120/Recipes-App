import 'package:flutter/material.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_model.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../view/edit_recipe_view.dart';

class EditRecipeItem extends StatelessWidget {
  const EditRecipeItem({super.key, required this.recipeModel});

  final RecipeModel recipeModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 165,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            image: DecorationImage(
              image: NetworkImage(
                recipeModel.recipePhoto ?? '',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.secondaryColor.withOpacity(.9),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  const Spacer(),
                  Text(recipeModel.recipeName ?? '',
                      style:
                          AppTextStyles.bold14.copyWith(color: Colors.white)),
                  const Spacer(
                    flex: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditRecipeView(recipeModel: recipeModel),
                        ),
                      );
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Text('Edit',
                            style: AppTextStyles.bold14
                                .copyWith(color: Colors.white))),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
