import 'package:flutter/material.dart';
import 'package:food_recipes/core/constants/app_colors.dart';
import 'package:food_recipes/core/utils/app_text_styles.dart';
import 'package:food_recipes/main_models/user_model.dart';

import '../../../../main_models/chef_model.dart';

class ChatUsersListViewItemForChef extends StatelessWidget {
  const ChatUsersListViewItemForChef({super.key, required this.user, this.onTap});

  final UserModel user;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration:  BoxDecoration(
          color:  Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.secondaryColor,
            width: 2
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            title: Text(user.name ?? '',style:  AppTextStyles.bold16.copyWith(
              color: AppColors.primaryColor
            ),),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                user.photoUrl ?? '',
              ),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
