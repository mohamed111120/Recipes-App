import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/app_text_styles.dart';

class DetailsRowWidget extends StatelessWidget {
  const DetailsRowWidget({super.key, required this.title, required this.value});

  final String? title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title??'',
          style: AppTextStyles.bold16.copyWith(color: Colors.black87),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.secondaryColor,
          ),
          child: Text(
            value??'',
            style: AppTextStyles.bold16.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
