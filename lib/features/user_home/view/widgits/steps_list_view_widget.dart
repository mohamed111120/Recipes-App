import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_model.dart';

import '../../../../core/constants/app_colors.dart';

class StepsListViewWidget extends StatelessWidget {
  const StepsListViewWidget({super.key, required this.recipeModel});
  final RecipeModel recipeModel;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: recipeModel.recipeSteps!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2,
                )),
            child: ExpandablePanel(
              theme: const ExpandableThemeData(
                hasIcon: false,
              ),
              header: Row(
                children: [
                  Text(' Step ${index + 1}',
                      style: const TextStyle(
                          color: AppColors.secondaryColor)),
                  const Spacer(),
                  const Icon(Icons.access_time_outlined,
                      size: 16, color: AppColors.secondaryColor),
                  Text(
                      recipeModel.recipeSteps![index].minutes
                          .toString(),
                      style: const TextStyle(
                          color: AppColors.secondaryColor)),
                ],
              ),
              collapsed: const SizedBox.shrink(),
              expanded: Container(
                padding: const EdgeInsets.symmetric( horizontal: 8 , vertical: 8),
                child: Text(
                  recipeModel.recipeSteps![index].step ?? '',
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
