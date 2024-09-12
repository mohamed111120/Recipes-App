import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/chef_home_layout/chef_home_layout.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../manager/chef_sign_up_cubit/chef_sign_up_cubit.dart';
import 'chef_sign_up_form.dart';

class ChefSignUpViewBody extends StatelessWidget {
  const ChefSignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChefSignUpCubit, ChefSignUpState>(
      listener: (context, state) {
        if (state is ChefSignUpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
        if (state is ChefSignUpSuccess) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChefHomeLayoutView(),
              ));
        }
      },
      builder: (context, state) {
        var chefCubit = ChefSignUpCubit.get(context);
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image:AssetImage(
                      'assets/auth_images/auth_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: ChefSignUpForm(),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      const Spacer(),
                      Align(
                        child: CustomButton(
                          text: 'Sign Up',
                          onTap: () {
                            if (chefCubit.formKey.currentState!.validate() &&
                                chefCubit.chefImageFile != null) {
                              chefCubit.chefSignUp();
                            } else {
                              chefCubit.autovalidateMode =
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
