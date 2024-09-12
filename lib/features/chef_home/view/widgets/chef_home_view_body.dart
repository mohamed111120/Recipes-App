import 'package:flutter/material.dart';
import 'package:food_recipes/core/constants/app_colors.dart';
import 'package:food_recipes/features/chef_add_recipes/view/chef_add_recipes_view.dart';

import '../../../../core/utils/app_text_styles.dart';

class ChefHomeViewBody extends StatelessWidget {
  const ChefHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Chef Name", style: AppTextStyles.bold24),
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
              style:
                  AppTextStyles.bold18.copyWith(color: AppColors.primaryColor),
            ),
            const SizedBox(height: 24),
            Text('No Reviews found yet.', style: AppTextStyles.bold24),
          ],
        ),
      ),
    );
  }
}
