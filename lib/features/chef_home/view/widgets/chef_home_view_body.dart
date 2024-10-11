import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/constants/app_colors.dart';
import 'package:food_recipes/features/chef_add_recipes/view/chef_add_recipes_view.dart';
import 'package:food_recipes/features/chef_home/manager/chef_home_cubit/chef_home_cubit.dart';
import 'package:food_recipes/features/chef_home/manager/chef_home_cubit/chef_home_cubit.dart';
import 'package:rate/rate.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../../../main_models/user_model.dart';
import '../../../user_recipe_page/manager/recipe_reviews_cubit/recipe_reviews_cubit.dart';

class ChefHomeViewBody extends StatelessWidget {
  const ChefHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChefHomeCubit, ChefHomeState>(
      builder: (context, state) {
        var cubit = ChefHomeCubit.get(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome ${cubit.currentChef?.name ?? ''}',
                        style: AppTextStyles.bold24),
                    const SizedBox(height: 12),
                    Text('Whats cooking today?',
                        style: AppTextStyles.bold24
                            .copyWith(color: AppColors.primaryColor)),
                  ],
                ),
                const SizedBox(height: 24),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChefAddRecipesView(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor,
                          ],
                        ),
                      ),
                      child: Text(
                        'Go To Add Recipes Page',
                        style: AppTextStyles.bold16.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Your Recipes Reviews',
                  style: AppTextStyles.bold18
                      .copyWith(color: AppColors.primaryColor),
                ),
                const SizedBox(height: 24),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cubit.chefReviews.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                        future: cubit.getUser(
                            userId: cubit.chefReviews[index].userUid!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.data!.data() == null) {
                            return const Center(
                              child: Text('No reviews found'),
                            );
                          } else {
                            UserModel user = snapshot.data?.data() as UserModel;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: AppColors.secondaryColor),
                                  child: Text(
                                    'RecipeName: ${cubit.recipes[index]?.recipeName ?? ''}',
                                    style: AppTextStyles.bold18.copyWith(
                                        color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: IntrinsicHeight(
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.primaryColor,
                                            width: 2),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(
                                                  user.photoUrl ?? '',
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  user.name ?? '',
                                                  style: AppTextStyles.bold18
                                                      .copyWith(
                                                          color: AppColors
                                                              .secondaryColor),
                                                ),
                                                Rate(
                                                  readOnly: true,
                                                  initialValue: cubit
                                                          .chefReviews[index]
                                                          .rating
                                                          ?.toDouble() ??
                                                      0,
                                                  iconSize: 20,
                                                  color: AppColors.primaryColor,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    cubit.chefReviews[index]
                                                            .review ??
                                                        '',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        });
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
