import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/chef_recipes/manger/chef_recipes_cubit.dart';
import 'package:food_recipes/features/chef_recipes/manger/chef_recipes_cubit.dart';

import '../../../../core/constants/app_colors.dart';

class DropDownSelectCategory extends StatelessWidget {
  const DropDownSelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChefRecipesCubit, ChefRecipesState>(
      builder: (context, state) {
        var cubit = ChefRecipesCubit.get(context);
        return DropdownButtonFormField(
          validator: (value) {
            if (value == null) {
              return 'Please Select Category';
            }
            return null;
          },
          decoration: InputDecoration(
            enabledBorder: buildOutlineInputBorderForCategory(),
            focusedBorder: buildOutlineInputBorderForCategory(),
            border: buildOutlineInputBorderForCategory(),
          ),
          value: cubit.recipeCategory,
          hint: const Text('Select Recipe Category'),
          items: [
            const DropdownMenuItem(
              value: 'Breakfast',
              child: Text('Breakfast'),
            ),
            const DropdownMenuItem(
              value: 'Lunch',
              child: Text('Lunch'),
            ),
            const DropdownMenuItem(
              value: 'Dinner',
              child: Text('Dinner'),
            ),
            const DropdownMenuItem(
              value: 'Another',
              child: Text('Another'),
            ),
          ],
          onChanged: (value) {
            cubit.changeRecipeCategory(
              value: value,
            );
          },
        );
      },
    );
  }

  OutlineInputBorder buildOutlineInputBorderForCategory() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.secondaryColor.withOpacity(.8),
          width: 2,
        ));
  }

}
