import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/constants/app_colors.dart';
import 'package:food_recipes/core/utils/app_text_styles.dart';
import 'package:food_recipes/core/widgets/custom_button.dart';
import 'package:food_recipes/features/chef_profile/manager/chef_profile_cubit.dart';

import 'details_row_widget.dart';

class ChefProfileViewBody extends StatelessWidget {
  const ChefProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChefProfileCubit, ChefProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var chefProfileCubit = ChefProfileCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                chefProfileCubit.currentChef?.photoUrl ?? ''),
                          ),
                          Text(
                            chefProfileCubit.currentChef?.name ?? '',
                            style: AppTextStyles.bold18
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            chefProfileCubit.currentChef?.address ?? '',
                            style: AppTextStyles.bold16
                                .copyWith(color: Colors.black38),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'you have now',
                                style: AppTextStyles.bold16
                                    .copyWith(color: Colors.black54),
                              ),
                              FutureBuilder(
                                  future: chefProfileCubit.getChefRecipes(),
                                  builder: (context, snapshot) {
                                    int chefRecipesNum =
                                        snapshot.data?.docs.length ?? 0;
                                    return Text(
                                      ' ${chefRecipesNum.toString()} ',
                                      style: AppTextStyles.bold16.copyWith(
                                          color: AppColors.primaryColor),
                                    );
                                  }),
                              Text(
                                'recipes',
                                style: AppTextStyles.bold16
                                    .copyWith(color: Colors.black54),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailsRowWidget(
                              title: 'Years of experience:',
                              value: chefProfileCubit
                                      .currentChef?.yearsOfExperience
                                      .toString() ??
                                  ''),
                          const SizedBox(height: 10),
                          DetailsRowWidget(
                              title: 'Email:',
                              value: chefProfileCubit.currentChef?.email ?? ''),
                          const SizedBox(height: 10),
                          DetailsRowWidget(
                              title: 'Phone number:',
                              value:
                                  chefProfileCubit.currentChef?.phoneNumber ??
                                      ''),
                          const SizedBox(height: 10),
                          DetailsRowWidget(
                              title: 'Address:',
                              value:
                                  chefProfileCubit.currentChef?.address ?? ''),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  child: Column(
                    children: [
                      Spacer(),
                      CustomButton(text: 'Edit Profile'),
                      SizedBox(
                        height: 38,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
