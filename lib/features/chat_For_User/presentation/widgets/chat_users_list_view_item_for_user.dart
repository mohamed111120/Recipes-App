import 'package:flutter/material.dart';
import 'package:food_recipes/core/constants/app_colors.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../../../main_models/chef_model.dart';

class ChatUsersListViewItemForUser extends StatelessWidget {
  const ChatUsersListViewItemForUser(
      {super.key, required this.chef, this.onTap});

  final ChefModel chef;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.secondaryColor, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            title: Text(
              chef.name ?? '',
              style:
                  AppTextStyles.bold16.copyWith(color: AppColors.primaryColor),
            ),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                chef.photoUrl ?? '',
              ),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
