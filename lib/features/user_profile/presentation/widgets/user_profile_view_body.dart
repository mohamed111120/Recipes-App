import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../chef_profile/widgets/details_row_widget.dart';
import '../../manager/user_profile_cubit.dart';

class UserProfileViewBody extends StatelessWidget {
  const UserProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileCubit, UserProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var chefProfileCubit = UserProfileCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
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
                                backgroundImage: NetworkImage(
                                    chefProfileCubit.currentUser?.photoUrl ?? ''),
                              ),
                              Text(
                                chefProfileCubit.currentUser?.name ?? '',
                                style: AppTextStyles.bold18
                                    .copyWith(color: Colors.black),
                              ),
                              Text(
                                chefProfileCubit.currentUser?.address ?? '',
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
                              value: chefProfileCubit.currentUser?.email ?? ''),
                          const SizedBox(height: 10),
                          DetailsRowWidget(
                              title: 'Phone number:',
                              value:
                              chefProfileCubit.currentUser?.phoneNumber ??
                                  ''),
                          const SizedBox(height: 10),
                          DetailsRowWidget(
                              title: 'Address:',
                              value:
                              chefProfileCubit.currentUser?.address ?? ''),
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
