import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/constants/app_colors.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/core/services/register_service.dart';
import 'package:food_recipes/core/utils/app_text_styles.dart';
import '../../../core/services/auth_service.dart';
import '../manager/user_home_cubit/user_home_cubit.dart';
import 'widgits/user_home_view_body.dart';

class UserHomeView extends StatelessWidget {
  const UserHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserHomeCubit(
        databaseService: getIt.get<DatabaseService>(),
        authService: getIt.get<AuthService>(),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.wb_sunny_outlined,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Good Morning',
                    style: AppTextStyles.regular14.copyWith(
                      color: const Color(0xff0A2533),
                    ),
                  ),
                ],
              ),
              const Icon(Icons.favorite_border,color:  AppColors.primaryColor,),
            ],
          ),
        ),
        body: const UserHomeViewBody(),
      ),
    );
  }
}
