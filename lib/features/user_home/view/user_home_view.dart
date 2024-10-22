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
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.fastfood ,color:  AppColors.primaryColor,),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    'Welcome To Recipes App',
                    style: AppTextStyles.bold20.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: const UserHomeViewBody(),
      ),
    );
  }
}
