import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/constants/app_colors.dart';
import 'package:food_recipes/core/utils/app_text_styles.dart';
import 'package:food_recipes/core/widgets/custom_button.dart';
import 'package:food_recipes/features/chef_profile/manager/chef_profile_cubit.dart';

import '../../../core/utils/custom_toast.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import 'details_row_widget.dart';

class ChefProfileViewBody extends StatelessWidget {
  const ChefProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChefProfileCubit, ChefProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          showToast(message: 'Edit profile success', state: ToastState.success);
          ChefProfileCubit.get(context).editProfileMode();
        }
      },
      builder: (context, state) {
        var chefProfileCubit = ChefProfileCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomScrollView(
            slivers: [
              chefProfileCubit.editMode == false
                  ? SliverToBoxAdapter(
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
                                      chefProfileCubit.currentChef?.photoUrl ??
                                          ''),
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
                                        future:
                                            chefProfileCubit.getChefRecipes(),
                                        builder: (context, snapshot) {
                                          int chefRecipesNum =
                                              snapshot.data?.docs.length ?? 0;
                                          return Text(
                                            ' ${chefRecipesNum.toString()} ',
                                            style: AppTextStyles.bold16
                                                .copyWith(
                                                    color:
                                                        AppColors.primaryColor),
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
                                    value:
                                        chefProfileCubit.currentChef?.email ??
                                            ''),
                                const SizedBox(height: 10),
                                DetailsRowWidget(
                                    title: 'Phone number:',
                                    value: chefProfileCubit
                                            .currentChef?.phoneNumber ??
                                        ''),
                                const SizedBox(height: 10),
                                DetailsRowWidget(
                                    title: 'Address:',
                                    value:
                                        chefProfileCubit.currentChef?.address ??
                                            ''),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: Form(
                        key: chefProfileCubit.formKey,
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                            chefProfileCubit
                                                    .currentChef?.photoUrl ??
                                                ''),
                                        child: const Align(
                                          alignment: Alignment.bottomRight,
                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            child: Icon(Icons.add,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Name',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      CustomTextFormField(
                                        hintText: chefProfileCubit
                                                .currentChef?.name ??
                                            '',
                                        controller:
                                            chefProfileCubit.nameController,
                                      ),
                                      const Text(
                                        'Email',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      CustomTextFormField(
                                        readOnly: true,
                                        validator: (p0) {},
                                        onTap: () {
                                          showToast(
                                              message:
                                                  'you can not change email',
                                              state: ToastState.error);
                                        },
                                        keyboardType: TextInputType.none,
                                        hintText: chefProfileCubit
                                                .currentChef?.email ??
                                            '',
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'phone number',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      CustomTextFormField(
                                        hintText: chefProfileCubit
                                                .currentChef?.phoneNumber ??
                                            '',
                                        controller: chefProfileCubit
                                            .phoneNumberController,
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Address',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      CustomTextFormField(
                                        hintText: chefProfileCubit
                                                .currentChef?.address ??
                                            '',
                                        controller:
                                            chefProfileCubit.addressController,
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Years of experience',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      CustomTextFormField(
                                        hintText: chefProfileCubit
                                                .currentChef?.yearsOfExperience
                                                .toString() ??
                                            '',
                                        controller: chefProfileCubit
                                            .yearsOfExperienceController,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  child: Column(
                    children: [
                      Spacer(),
                      chefProfileCubit.editMode == false
                          ? CustomButton(
                              text: 'Edit Profile',
                              onTap: () {
                                chefProfileCubit.editProfileMode();
                              },
                            )
                          : CustomButton(
                              text: 'Submit Edit Profile',
                              onTap: () {
                                if (chefProfileCubit.formKey.currentState!
                                    .validate()) {
                                  chefProfileCubit.editChefProfile(
                                    name: chefProfileCubit.nameController.text,
                                    address:
                                        chefProfileCubit.addressController.text,
                                    phoneNumber: chefProfileCubit
                                        .phoneNumberController.text,
                                    yearsOfExperience: chefProfileCubit
                                        .yearsOfExperienceController.text,
                                  );
                                }
                              },
                            ),
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
