import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/widgets/custom_button.dart';
import 'package:food_recipes/features/auth/chef_auth/manager/chef_login_cubit/chef_login_cubit.dart';
import 'package:food_recipes/features/auth/chef_auth/manager/chef_sign_up_cubit/chef_sign_up_cubit.dart';
import 'package:food_recipes/features/auth/chef_auth/manager/chef_sign_up_cubit/chef_sign_up_cubit.dart';
import 'package:food_recipes/features/chef_home/view/chef_home_view.dart';
import 'package:food_recipes/features/chef_home_layout/chef_home_layout.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';

class ChefLoginViewBody extends StatelessWidget {
  const ChefLoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChefLoginCubit, ChefLoginState>(
      listener: (context, state) {
        if (state is ChefLoginError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
        if (state is ChefLoginSuccess) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChefHomeLayoutView(),
              ));
        }
      },
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/auth_images/auth_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: ChefLoginCubit.get(context).formKey,
              autovalidateMode: ChefLoginCubit.get(context).autoValidateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Email Address',
                    style: AppTextStyles.bold16
                        .copyWith(color: AppColors.secondaryColor),
                  ),
                  CustomTextFormField(
                    controller: ChefLoginCubit.get(context).emailController,
                    prefixIcon: Icons.person,
                  ),
                  Text(
                    'Password',
                    style: AppTextStyles.bold16
                        .copyWith(color: AppColors.secondaryColor),
                  ),
                  CustomTextFormField(
                    controller: ChefLoginCubit.get(context).passwordController,
                    prefixIcon: Icons.person,
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                      text: 'Login',
                      onTap: () {
                        if (ChefLoginCubit.get(context)
                            .formKey
                            .currentState!
                            .validate()) {
                          ChefLoginCubit.get(context).chefLogin();
                        } else {
                          ChefLoginCubit.get(context).autoValidateMode =
                              AutovalidateMode.always;
                        }
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
