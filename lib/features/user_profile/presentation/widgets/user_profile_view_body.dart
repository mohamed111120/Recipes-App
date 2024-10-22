import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/utils/custom_toast.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../chef_profile/widgets/details_row_widget.dart';
import '../../manager/user_profile_cubit.dart';

class UserProfileViewBody extends StatelessWidget {
  const UserProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileCubit, UserProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          showToast(message: ' Edit profile success', state: ToastState.success);
          UserProfileCubit.get(context).editProfileMode();
        }
      },
      builder: (context, state) {
        var userProfileCubit = UserProfileCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomScrollView(
            slivers: [
              userProfileCubit.editMode == false
                  ? SliverToBoxAdapter(
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(userProfileCubit
                                              .currentUser?.photoUrl ??
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJi-tCzrU2VSYEVPxSq5LNF2xiHwtxy10c0A&s'),
                                    ),
                                    Text(
                                      userProfileCubit.currentUser?.name ?? '',
                                      style: AppTextStyles.bold18
                                          .copyWith(color: Colors.black),
                                    ),
                                    Text(
                                      userProfileCubit.currentUser?.address ??
                                          '',
                                      style: AppTextStyles.bold16
                                          .copyWith(color: Colors.black38),
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
                                    title: 'Email:',
                                    value:
                                        userProfileCubit.currentUser?.email ??
                                            ''),
                                const SizedBox(height: 10),
                                DetailsRowWidget(
                                    title: 'Phone number:',
                                    value: userProfileCubit
                                            .currentUser?.phoneNumber ??
                                        ''),
                                const SizedBox(height: 10),
                                DetailsRowWidget(
                                    title: 'Address:',
                                    value:
                                        userProfileCubit.currentUser?.address ??
                                            ''),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: Form(
                        key: userProfileCubit.formKey,
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
                                            userProfileCubit
                                                    .currentUser?.photoUrl ??
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
                                        hintText: userProfileCubit
                                                .currentUser?.name ??
                                            '',
                                        controller:
                                            userProfileCubit.nameController,
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
                                        hintText: userProfileCubit
                                                .currentUser?.email ??
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
                                        hintText: userProfileCubit
                                                .currentUser?.phoneNumber ??
                                            '',
                                        controller: userProfileCubit
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
                                        hintText: userProfileCubit
                                                .currentUser?.address ??
                                            '',
                                        controller:
                                            userProfileCubit.addressController,
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
                      const Spacer(),
                      userProfileCubit.editMode == false
                          ? CustomButton(
                              text: 'Edit Profile',
                              onTap: () {
                                userProfileCubit.editProfileMode();
                              },
                            )
                          : CustomButton(
                              text: 'Submit Edit Profile',
                              onTap: () {
                                if (userProfileCubit.formKey.currentState!
                                    .validate()) {
                                  userProfileCubit.editUserProfile(
                                    name: userProfileCubit.nameController.text,
                                    address:
                                        userProfileCubit.addressController.text,
                                    phoneNumber: userProfileCubit
                                        .phoneNumberController.text,
                                  );
                                }
                              },
                            ),
                      const SizedBox(
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
