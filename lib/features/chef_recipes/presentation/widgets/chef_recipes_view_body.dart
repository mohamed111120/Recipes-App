import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/chef_recipes/manger/chef_recipes_cubit.dart';
import 'package:food_recipes/features/chef_recipes/presentation/widgets/edit_recipe_item.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_model.dart';
import '../../../../core/utils/app_text_styles.dart';

class ChefRecipesViewBody extends StatelessWidget {
  const ChefRecipesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChefRecipesCubit, ChefRecipesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var chefProfileCubit = ChefRecipesCubit.get(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'you can click on Edit to see details and be able to Edit it.',
                  style: AppTextStyles.bold16.copyWith(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),
                FutureBuilder(
                  future: chefProfileCubit.getChefRecipes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length ?? 0,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 2 / 2.8,
                        ),
                        itemBuilder: (context, index) {
                          RecipeModel? recipeModel =
                          snapshot.data?.docs[index].data();

                          return EditRecipeItem(
                              recipeModel: recipeModel!);
                        },
                      );
                      // ToDo: Why this issue?
                    } else if (snapshot.hasData &&   snapshot.data?.docs == []) {
                      return const Center(
                          child: Text(
                            'No Data Found',
                            style: TextStyle(color: Colors.black),
                          ));
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
