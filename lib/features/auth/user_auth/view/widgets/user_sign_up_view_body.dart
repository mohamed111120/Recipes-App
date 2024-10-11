import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/utils/custom_toast.dart';
import 'package:food_recipes/core/widgets/custom_button.dart';
import 'package:food_recipes/features/user_home_layout/user_home_layout_view.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../manager/user_sign_up_cubit/user_sign_up_cubit.dart';
import 'user_sign_up_form.dart';

class UserSignUpViewBody extends StatelessWidget {
  const UserSignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSignUpCubit, UserSignUpState>(
      listener: (context, state) {
        if (state is UserSignUpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
        if (state is UserSignUpSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const UserHomeLayoutView(),
              ),
              (route) => false);
        }
      },
      builder: (context, state) {
        UserSignUpCubit userCubit = UserSignUpCubit.get(context);
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/auth_images/auth_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: UserSignUpForm(),
                ),
                BlocBuilder<UserSignUpCubit, UserSignUpState>(
                  builder: (context, state) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [
                          const Spacer(),
                          Align(
                            child: state is UserSignUpLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.secondaryColor,
                                    ),
                                  )
                                : CustomButton(
                                    text: 'Sign Up',
                                    onTap: () {
                                      if (userCubit.formKey.currentState!
                                              .validate() &&
                                          userCubit.userImageFile != null) {
                                        userCubit.userSignUp();
                                      } else {
                                        if (userCubit.userImageFile == null) {
                                          showToast(
                                              message: 'Please Add Image',
                                              state: ToastState.error);
                                        }
                                        userCubit.autovalidateMode =
                                            AutovalidateMode.always;
                                      }
                                    },
                                  ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
