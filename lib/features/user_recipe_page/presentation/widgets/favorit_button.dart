import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/cache/shered_manager.dart';
import 'package:food_recipes/features/user_recipe_page/manager/favorits_cubit/favorits_cubit.dart';
import 'package:food_recipes/features/user_recipe_page/manager/favorits_cubit/favorits_cubit.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/shared_keys.dart';

class FavoritButton extends StatelessWidget {
  const FavoritButton({
    super.key,
    required this.recipeId,
  });

  final String recipeId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritsCubit, FavoritsState>(
      builder: (context, state) {
        var cubit = FavoritsCubit.get(context);
        return Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              cubit.isFavorite
                  ? cubit.removeFromFavorite(
                      userId: SharedService.get(key: SharedKeys.uid),
                      recipeId: recipeId,
                    )
                  : cubit.addToFavorite(
                      userId: SharedService.get(key: SharedKeys.uid),
                      recipeId: recipeId,
                    );
            },
            child: Icon(
                cubit.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: AppColors.primaryColor,
                size: 36),
          ),
        );
      },
    );
  }
}
