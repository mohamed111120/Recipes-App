import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/constants/app_colors.dart';
import 'package:food_recipes/features/chef_add_recipes/view/widgets/custom_add_recipes_minutes_text_form_field.dart';

import '../../../../core/widgets/custom_text_form_field.dart';
import '../../manager/add_recipres_cubit/add_recipes_cubit.dart';

class ChefAddRecipesStepsListView extends StatelessWidget {
  const ChefAddRecipesStepsListView({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: count,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                stepNum: index + 1,
                controller: context
                    .read<AddRecipesCubit>()
                    .stepsTextControllers?[index],
              ),
            ),
            SizedBox(width: 24),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.secondaryColor.withOpacity(.8),
              ),
              width: 65,
              height: 65,
              child: Center(
                child: CustomAddRecipesMinutesTextFormField(
                  controller: context
                      .read<AddRecipesCubit>()
                      .minutesTextControllers?[index],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
