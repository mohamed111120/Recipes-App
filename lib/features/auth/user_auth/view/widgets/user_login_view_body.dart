import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/widgets/custom_button.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../user_home_layout/user_home_layout_view.dart';
import '../../manager/user_login_cubit/user_login_cubit.dart';

class UserLoginViewBody extends StatelessWidget {
  const UserLoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLoginCubit, UserLoginState>(
      listener: (context, state) {
        if (state is UserLoginError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
        if (state is UserLoginSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const UserHomeLayoutView(),
              ),
              (route) => false);
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
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Form(
                          key: UserLoginCubit.get(context).formKey,
                          autovalidateMode:
                              UserLoginCubit.get(context).autoValidateMode,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/icons/login_user.png',
                                  height: 100,
                                ),
                              ),
                              SizedBox(height: 50),
                              Text(
                                'Email Address',
                                style: AppTextStyles.bold16
                                    .copyWith(color: AppColors.secondaryColor),
                              ),
                              CustomTextFormField(
                                controller:
                                    UserLoginCubit.get(context).emailController,
                                prefixIcon: Icons.person,
                              ),
                              Text(
                                'Password',
                                style: AppTextStyles.bold16
                                    .copyWith(color: AppColors.secondaryColor),
                              ),
                              CustomTextFormField(
                                controller:
                                    UserLoginCubit.get(context).passwordController,
                                prefixIcon: Icons.password,
                              ),
                              SizedBox(height: 20),
                              CustomButton(
                                  text: 'Login',
                                  onTap: () {
                                    if (UserLoginCubit.get(context)
                                        .formKey
                                        .currentState!
                                        .validate()) {
                                      UserLoginCubit.get(context).userLogin();
                                    } else {
                                      UserLoginCubit.get(context).autoValidateMode =
                                          AutovalidateMode.always;
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),

                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
