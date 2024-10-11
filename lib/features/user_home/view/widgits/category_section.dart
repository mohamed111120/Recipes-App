import 'package:flutter/material.dart';
import 'package:food_recipes/features/single_category_view/presentation/view/single_category_view.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: AppTextStyles.bold20,
              ),
              Text('See all',
                  style: AppTextStyles.bold14
                      .copyWith(color: AppColors.primaryColor)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SingleCategoryView(
                          categoryName: 'Breakfast',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 41,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: AppColors.primaryColor,
                    ),
                    child: const Center(
                        child: Text(
                      'Breakfast',
                      style: AppTextStyles.regular16,
                    )),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SingleCategoryView(
                          categoryName: 'Lunch',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 41,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: AppColors.primaryColor,
                    ),
                    child: const Center(
                        child: Text(
                      'Lunch',
                      style: AppTextStyles.regular16,
                    )),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SingleCategoryView(
                          categoryName: 'Dinner',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 41,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: AppColors.primaryColor,
                    ),
                    child: const Center(
                        child: Text(
                      'Dinner',
                      style: AppTextStyles.regular16,
                    )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
