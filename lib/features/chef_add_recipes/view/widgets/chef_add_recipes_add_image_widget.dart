import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/utils/app_text_styles.dart';
import 'package:food_recipes/features/chef_add_recipes/manager/add_recipres_cubit/add_recipes_cubit.dart';

import '../../../../core/constants/app_colors.dart';

class ChefAddRecipesAddImageWidget extends StatelessWidget {
  const ChefAddRecipesAddImageWidget({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddRecipesCubit, AddRecipesState>(
      builder: (context, state) {
        var recipesCubit = AddRecipesCubit.get(context);
        return GestureDetector(
          onTap: onTap,
          child: Column(
            crossAxisAlignment:  CrossAxisAlignment.start,
            children: [
              const Text(
                'Recipe Image',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    image: recipesCubit.recipeImageUrl == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(context
                                .read<AddRecipesCubit>()
                                .recipeImageUrl!),
                          )),
                child: state is UploadRecipeImageLoading
                    ? const Center(child: CircularProgressIndicator())
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }
}
