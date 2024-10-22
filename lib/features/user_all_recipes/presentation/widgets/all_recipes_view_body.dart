import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/user_all_recipes/manager/all_recipes_cubit.dart';
import 'package:food_recipes/features/user_all_recipes/manager/all_recipes_cubit.dart';
import 'package:food_recipes/main_models/chef_model.dart';

import '../../../user_home/view/widgits/featured_list_view_item.dart';

class AllRecipesViewBody extends StatelessWidget {
  const AllRecipesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllRecipesCubit, AllRecipesState>(
      builder: (context, state) {
        var cubit = AllRecipesCubit.get(context);
        return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: cubit.allRecipes.length,
                itemBuilder: (context, index) {
                  return
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder(
                         future:  cubit.getChef(uid: cubit.allRecipes[index].chefUid! ),
                        builder: (context , snapShot) {
                          return FeaturedListViewItem(
                            recipeModel: cubit.allRecipes[index],
                            chefModel: snapShot.data as ChefModel,
                            onTap: () {
                            },

                          );
                        }
                      ),
                    );
                },
              ),
            ));
      },
    );
  }
}
