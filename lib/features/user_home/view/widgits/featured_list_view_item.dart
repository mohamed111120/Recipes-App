import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipes/features/user_home/manager/user_home_cubit/user_home_cubit.dart';
import 'package:food_recipes/main_models/chef_model.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_model.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../user_recipe_page/presentation/view/user_recipe_view.dart';

class FeaturedListViewItem extends StatelessWidget {
  const FeaturedListViewItem({
    super.key,
    required this.recipeModel,
    required this.chefModel,
  });

  final RecipeModel recipeModel;
  final ChefModel chefModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        await UserHomeCubit.get(context)
            .updateRecipeCount(recipeId: recipeModel.recipeId ?? '');
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return UserRecipeView(
              recipeModel: recipeModel,
              chefModel: chefModel,
            );
          },
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 264,
        height: 172,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(recipeModel.recipePhoto ?? ''),
          ),
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    recipeModel.recipeName ?? '',
                    style: AppTextStyles.bold18,
                  ),
                ),
                const Spacer(
                  flex: 1,
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        radius: 12,
                        backgroundImage: Image.network(chefModel.photoUrl!,
                                fit: BoxFit.cover)
                            .image),
                    const SizedBox(width: 4),
                    Text(
                      chefModel.name ?? '',
                      style: AppTextStyles.regular14White,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(recipeModel.recipeTime.toString() ?? 0.toString(),
                        style: AppTextStyles.regular14White),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
