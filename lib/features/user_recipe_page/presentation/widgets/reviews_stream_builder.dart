import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_recipes/core/constants/app_colors.dart';
import 'package:food_recipes/core/utils/app_text_styles.dart';
import 'package:food_recipes/main_models/chef_model.dart';
import 'package:rate/rate.dart';

import '../../../../main_models/recipe_model/recipe_model.dart';
import '../../../../main_models/user_model.dart';
import '../../manager/recipe_reviews_cubit/recipe_reviews_cubit.dart';

class ReviewsStreamBuilder extends StatelessWidget {
  const ReviewsStreamBuilder({super.key, required this.recipeModel});

  final RecipeModel recipeModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: RecipeReviewsCubit.get(context)
            .getRecipeReviews(recipeId: recipeModel.recipeId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.data() == null) {
            return const Center(
              child: Text('No reviews found'),
            );
          } else {
            RecipeModel recipe = snapshot.data?.data() as RecipeModel;
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recipe.recipeReviews?.length ?? 0,
              itemBuilder: (context, index) {
                return FutureBuilder(
                    future: RecipeReviewsCubit.get(context)
                        .getUser(userId: recipe.recipeReviews![index].userUid!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.data!.data() == null) {
                        return const Center(
                          child: Text('No reviews found'),
                        );
                      } else {
                        UserModel user = snapshot.data?.data() as UserModel;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: IntrinsicHeight(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(8.0),
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
                                          style: AppTextStyles.bold18.copyWith(
                                              color: AppColors.secondaryColor),
                                        ),
                                        Rate(
                                          readOnly: true,
                                          initialValue: recipe
                                                  .recipeReviews?[index].rating
                                                  ?.toDouble() ??
                                              0,
                                          iconSize: 20,
                                          color: AppColors.primaryColor,
                                        ),
                                        Expanded(
                                          child: Text(
                                            recipe.recipeReviews?[index].review ??
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
                        );
                      }
                    });
              },
            );
          }
        });
  }
}
