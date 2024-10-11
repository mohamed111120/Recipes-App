import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/user_home/view/widgits/featured_list_view_item.dart';

import '../../../../main_models/chef_model.dart';
import '../../../user_recipe_page/presentation/view/user_recipe_view.dart';
import '../../manager/favorites_list_cubit/favorites_list_cubit.dart';

class UserFavoritesViewBody extends StatelessWidget {
  const UserFavoritesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesListCubit, FavoritesListState>(
      builder: (context, state) {
        var favoritesListCubit = FavoritesListCubit.get(context);
        return ListView.builder(
          itemCount: favoritesListCubit.favoritesRecipesList.length,
          itemBuilder: (context, index) {
            return FutureBuilder(
                future: favoritesListCubit.getChef(
                    chefId: favoritesListCubit
                        .favoritesRecipesList[index].chefUid!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          await favoritesListCubit.updateRecipeCount(
                              recipeId: favoritesListCubit
                                      .favoritesRecipesList[index].recipeId ??
                                  '');
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return UserRecipeView(
                                recipeModel: favoritesListCubit
                                    .favoritesRecipesList[index],
                                chefModel: snapshot.data!.data() as ChefModel,
                              );
                            },
                          ));
                        },
                        child: FeaturedListViewItem(
                          recipeModel:
                              favoritesListCubit.favoritesRecipesList[index],
                          chefModel: snapshot.data!.data() as ChefModel,
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                });
          },
        );
      },
    );
  }
}
