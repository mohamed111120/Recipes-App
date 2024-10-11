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
            prefixIcon: Icons.email,
            validator: (value) {
              if (value == null || value.isEmpty || !isEmail(value)) {
                return 'Please enter valid password';
              } else {
                return null;
              }
            },
          ),
          Text(
            'Phone Number',
            style:
                AppTextStyles.bold16.copyWith(color: AppColors.secondaryColor),
          ),
          CustomTextFormField(
            keyboardType: TextInputType.phone,
            controller: ChefSignUpCubit.get(context).phoneNumberController,
            prefixIcon: Icons.phone_android,
          ),
          Text(
            'Password',
            style:
                AppTextStyles.bold16.copyWith(color: AppColors.secondaryColor),
          ),
          CustomTextFormField(
            controller: ChefSignUpCubit.get(context).passwordController,
            prefixIcon: Icons.password,
            validator: (value) {
              if (value == null || value.isEmpty || !validatePassWord(value)) {
                return 'Please enter valid password';
              } else {
                return null;
              }
            },
          ),
          Text(
            'Confirm Password',
            style:
                AppTextStyles.bold16.copyWith(color: AppColors.secondaryColor),
          ),
          CustomTextFormField(
            prefixIcon: Icons.password,
            validator:  (value) {
              if (value == null ||
                  value.isEmpty ||
                  ChefSignUpCubit.get(context).passwordController?.text != value) {
                return 'Please enter text';
              } else {
                return null;
              }
            },
          ),
          Text(
            'Address',
            style:
                AppTextStyles.bold16.copyWith(color: AppColors.secondaryColor),
          ),
          CustomTextFormField(
            controller: ChefSignUpCubit.get(context).addressController,
            prefixIcon: Icons.add_location_alt_rounded,
          ),
          Text(
            'Years Of Experience',
            style:
                AppTextStyles.bold16.copyWith(color: AppColors.secondaryColor),
          ),
          CustomTextFormField(
            keyboardType: TextInputType.number,
            controller: ChefSignUpCubit.get(context).yearsOfExperience,
            prefixIcon: Icons.info,
          ),
        ],
      ),
    );
  }
  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }

  bool validatePassWord(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
