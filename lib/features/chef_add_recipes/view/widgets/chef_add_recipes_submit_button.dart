import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/chef_add_recipes/manager/add_recipres_cubit/add_recipes_cubit.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';

class ChefAddRecipesSubmitButton extends StatelessWidget {
  const ChefAddRecipesSubmitButton({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return  Align(
      child: CustomButton(
        onTap: onTap,
        color: AppColors.primaryColor,
        text: 'Submit Your Recipe',
      ),
    );
  }
}
