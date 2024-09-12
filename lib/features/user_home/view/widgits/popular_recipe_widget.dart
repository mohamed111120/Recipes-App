import 'package:flutter/material.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_model.dart';

import '../../../../core/utils/app_text_styles.dart';

class PopularRecipeWidget extends StatelessWidget {
  const PopularRecipeWidget({super.key, required this.recipeModel, this.onTap});

  final RecipeModel recipeModel;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            width: 200,
            height: 245,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  height: 128,
                  width: 168,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          recipeModel.recipePhoto ??
                              'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=600',
                        ),
                      )),
                ),
                const SizedBox(height: 12),
                Text(
                  recipeModel.recipeDescription ?? '',
                  style: AppTextStyles.bold16.copyWith(color: Colors.black),
                  maxLines: 2,
                  overflow:  TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department_outlined,
                      color: Color(0xff97A2B0),
                      size: 18,
                    ),
                    Text(
                      recipeModel.calories?.toString() ?? '0',
                      style: AppTextStyles.regular14
                          .copyWith(color: const Color(0xff97A2B0)),
                    ),
                    const SizedBox(width: 2),
                    const Spacer(),
                    const CircleAvatar(
                      radius: 2,
                      backgroundColor: Color(0xff97A2B0),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.access_time,
                      color: Color(0xff97A2B0),
                      size: 18,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${recipeModel.recipeTime} min',
                      style: AppTextStyles.regular14
                          .copyWith(color: const Color(0xff97A2B0)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
