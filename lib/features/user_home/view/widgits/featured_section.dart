import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/user_home/manager/user_home_cubit/user_home_cubit.dart';
import 'package:food_recipes/main_models/chef_model.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_model.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../../user_recipe_page/presentation/view/user_recipe_view.dart';
import 'featured_list_view_item.dart';

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserHomeCubit, UserHomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var userHomeCubit = UserHomeCubit.get(context);
        return StreamBuilder(
          stream: userHomeCubit.getFeaturedRecipes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text("Featured", style: AppTextStyles.bold20),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      height: 172,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          RecipeModel recipe =
                              snapshot.data!.docs[index].data();
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: FutureBuilder(
                                future: userHomeCubit.getChef(
                                    chefId: recipe.chefUid ?? ''),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    ChefModel chef =
                                        snapshot.data?.data() as ChefModel;
                                    return GestureDetector(
                                      onTap: () async{
                                        await UserHomeCubit.get(context)
                                            .updateRecipeCount(recipeId: recipe.recipeId ?? '');
                                        Navigator.push(context, MaterialPageRoute(
                                          builder: (context) {
                                            return UserRecipeView(
                                              recipeModel: recipe,
                                              chefModel: chef,
                                            );
                                          },
                                        ));
                                      },
                                      child: FeaturedListViewItem(
                                        recipeModel: recipe,
                                        chefModel: chef,
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }),
                          );
                        },
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }
}
