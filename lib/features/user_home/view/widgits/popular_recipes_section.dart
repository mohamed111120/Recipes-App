import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_recipes/features/user_home/manager/user_home_cubit/user_home_cubit.dart';
import 'package:food_recipes/features/user_home/view/widgits/popular_recipe_widget.dart';
import 'package:food_recipes/main_models/chef_model.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../main_models/recipe_model/recipe_model.dart';
import '../../../user_recipe_page/presentation/view/user_recipe_view.dart';

class PopularRecipesSection extends StatelessWidget {
  const PopularRecipesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Popular Recipes",
                style: AppTextStyles.bold24,
              ),
              Text(
                "See All",
                style: AppTextStyles.bold14
                    .copyWith(color: AppColors.primaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        StreamBuilder(
            stream: UserHomeCubit.get(context).getPopularRecipes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No recipes found!'),
                );
              } else if (snapshot.hasData) {
                List<QueryDocumentSnapshot<RecipeModel>> popularRecipes =
                    snapshot.data!.docs
                        as List<QueryDocumentSnapshot<RecipeModel>>;
                popularRecipes.sort(
                  (a, b) {
                    return b
                            .data()
                            .clickCount
                            ?.compareTo(a.data().clickCount as num) ??
                        0;
                  },
                );
                print(popularRecipes.length);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    height: 245,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: popularRecipes.length ?? 0,
                      itemBuilder: (context, index) {
                        return PopularRecipeWidget(
                          onTap: () async {
                            await UserHomeCubit.get(context).updateRecipeCount(
                              recipeId:
                                  popularRecipes[index].data().recipeId ?? '',
                            );
                            var chef = await UserHomeCubit.get(context).getChef(
                                chefId:
                                    popularRecipes[index].data().chefUid ?? '');

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return UserRecipeView(
                                    recipeModel: popularRecipes[index].data(),
                                    chefModel: chef.data() as ChefModel,
                                  );
                                },
                              ),
                            );
                          },
                          recipeModel: popularRecipes[index].data(),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text('Something went wrong!'),
                );
              }
            })
      ],
    );
  }
}
