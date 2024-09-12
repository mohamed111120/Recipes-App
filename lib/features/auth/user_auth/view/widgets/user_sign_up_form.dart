import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/constants/app_colors.dart';
import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../auth_widgets/add_photo_widget.dart';
import '../../manager/user_sign_up_cubit/user_sign_up_cubit.dart';

class UserSignUpForm extends StatelessWidget {
  const UserSignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: UserSignUpCubit.get(context).formKey,
      autovalidateMode: UserSignUpCubit.get(context).autovalidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          BlocBuilder<UserSignUpCubit, UserSignUpState>(
            builder: (context, state) {
              return Center(
                child: AddPhotoWidget(
                  file: UserSignUpCubit.get(context).userImageFile,
                  onTap: () async {
                    await UserSignUpCubit.get(context).getImageFromGallary();
                  },
                ),
              );
            },
          ),
          Text('Name',
              style: AppTextStyles.bold16
                  .copyWith(color: AppColors.secondaryColor)),
          CustomTextFormField(
            controller: UserSignUpCubit.get(context).nameController,
            prefixIcon: Icons.person,
          ),
          Text(
            'Email Address',
            style:
                AppTextStyles.bold16.copyWith(color: AppColors.secondaryColor),
          ),
          CustomTextFormField(
            controller: UserSignUpCubit.get(context).emailController,
            prefixIcon: Icons.person,
          ),
          Text(
            'Phone Number',
            style:
                AppTextStyles.bold16.copyWith(color: AppColors.secondaryColor),
          ),
          CustomTextFormField(
            controller: UserSignUpCubit.get(context).phoneNumberController,
            prefixIcon: Icons.person,
          ),
          Text(
            'Password',
            style:
                AppTextStyles.bold16.copyWith(color: AppColors.secondaryColor),
          ),
          CustomTextFormField(
            controller: UserSignUpCubit.get(context).passwordController,
            prefixIcon: Icons.person,
          ),
          Text(
            'Confirm Password',
            style:
                AppTextStyles.bold16.copyWith(color: AppColors.secondaryColor),
          ),
          CustomTextFormField(
            // ToDo Confirm Password
            prefixIcon: Icons.person,
          ),
          Text(
            'Address',
            style:
                AppTextStyles.bold16.copyWith(color: AppColors.secondaryColor),
          ),
          CustomTextFormField(
            controller: UserSignUpCubit.get(context).addressController,
            prefixIcon: Icons.person,
          ),
        ],
      ),
    );
  }
}
