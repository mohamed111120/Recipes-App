import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/auth/chef_auth/manager/chef_sign_up_cubit/chef_sign_up_cubit.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../auth_widgets/add_photo_widget.dart';

class ChefSignUpForm extends StatelessWidget {
  const ChefSignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ChefSignUpCubit.get(context).formKey,
      autovalidateMode: ChefSignUpCubit.get(context).autovalidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          BlocBuilder<ChefSignUpCubit, ChefSignUpState>(
            builder: (context, state) {
              return Center(
                child: AddPhotoWidget(
                  onTap: () async =>
                      await ChefSignUpCubit.get(context).getImageFromGallary(),
                  file: ChefSignUpCubit.get(context).chefImageFile,
                ),
              );
            },
          ),
          Text('Name',
              style: AppTextStyles.bold16
                  .copyWith(color: AppColors.secondaryColor)),
          CustomTextFormField(
            controller: ChefSignUpCubit.get(context).nameController,
            prefixIcon: Icons.person,
          ),
          Text(
            'Email Address',
            style:
                AppTextStyles.bold16.copyWith(color: AppColors.secondaryColor),
          ),
          CustomTextFormField(
            controller: ChefSignUpCubit.get(context).emailController,
            prefixIcon: Icons.person,
          ),
          Text(
            'Phone Number',
            style:
                AppTextStyles.bold16.copyWith(color: AppColors.secondaryColor),
          ),
          CustomTextFormField(
            keyboardType: TextInputType.phone,
            controller: ChefSignUpCubit.get(context).phoneNumberController,
            prefixIcon: Icons.person,
          ),
          Text(
            'Password',
            style:
                AppTextStyles.bold16.copyWith(color: AppColors.secondaryColor),
          ),
          CustomTextFormField(
            controller: ChefSignUpCubit.get(context).passwordController,
            prefixIcon: Icons.person,
          ),
          Text(
            'Confirm Password',
            style:
                AppTextStyles.bold16.copyWith(color: AppColors.secondaryColor),
          ),
          CustomTextFormField(
            // TODO : add confirm password
            prefixIcon: Icons.person,
          ),
          Text(
            'Address',
            style:
                AppTextStyles.bold16.copyWith(color: AppColors.secondaryColor),
          ),
          CustomTextFormField(
            controller: ChefSignUpCubit.get(context).addressController,
            prefixIcon: Icons.person,
          ),
          Text(
            'Years Of Experience',
            style:
                AppTextStyles.bold16.copyWith(color: AppColors.secondaryColor),
          ),
          CustomTextFormField(
            keyboardType: TextInputType.number,
            controller: ChefSignUpCubit.get(context).yearsOfExperience,
            prefixIcon: Icons.person,
          ),
        ],
      ),
    );
  }
}
