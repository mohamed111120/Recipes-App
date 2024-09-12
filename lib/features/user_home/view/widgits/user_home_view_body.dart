import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/user_home/manager/user_home_cubit/user_home_cubit.dart';
import 'package:food_recipes/features/user_home/view/widgits/popular_recipes_section.dart';
import '../../../../core/utils/app_text_styles.dart';
import 'category_section.dart';
import 'featured_section.dart';

class UserHomeViewBody extends StatefulWidget {
  const UserHomeViewBody({super.key});

  @override
  State<UserHomeViewBody> createState() => _UserHomeViewBodyState();
}

class _UserHomeViewBodyState extends State<UserHomeViewBody> {
  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future<void> getUser() async {
    await UserHomeCubit.get(context).getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserHomeCubit, UserHomeState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(UserHomeCubit
                    .get(context)
                    .currentUser
                    ?.name ?? '',
                    style: AppTextStyles.bold24),
              ),
              const SizedBox(height: 24),
              const FeaturedSection(),
              const CategorySection(),
              const PopularRecipesSection(),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
