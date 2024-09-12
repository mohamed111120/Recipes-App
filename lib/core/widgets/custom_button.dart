import 'package:flutter/material.dart';
import 'package:food_recipes/core/constants/app_colors.dart';

import '../utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    required this.text,
    this.color,
  });

  final void Function()? onTap;
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color?? AppColors.secondaryColor,
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.bold16,
          ),
        ),
      ),
    );
  }
}
