import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/user_home/view/widgits/featured_list_view_item.dart';
import '../../../user_recipe_page/presentation/view/user_recipe_view.dart';
import '../../manager/single_category_cubit.dart';

class SingleCategoryViewBody extends StatelessWidget {
  const SingleCategoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SingleCategoryCubit, SingleCategoryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var singleCategoryCubit = SingleCategoryCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
              child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: singleCategoryCubit.recipesCategory.length,
            itemBuilder: (context, index) {
              return FutureBuilder(
                future: singleCategoryCubit.getChef(
                    chefId:
                        singleCategoryCubit.recipesCategory[index].chefUid ??
                            ''),
                builder: (context, snapshot)  {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: GestureDetector(
                        onTap: () async{
                          await singleCategoryCubit
                              .updateRecipeCount(recipeId: singleCategoryCubit.recipesCategory[index].recipeId ?? '');
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return UserRecipeView(
                                recipeModel: singleCategoryCubit.recipesCategory[index],
                                chefModel: snapshot.data!,
                              );
                            },
                          ));
                        },
                        child: FeaturedListViewItem(
                          recipeModel: singleCategoryCubit.recipesCategory[index],
                          chefModel: snapshot.data!,
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              );
            },
          )),
        );
      },
    );
  }
}
