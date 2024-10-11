import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/register_service.dart';
import 'package:food_recipes/features/chef_home/manager/chef_home_cubit/chef_home_cubit.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/database_service.dart';
import '../../../core/utils/app_text_styles.dart';
import 'widgets/chef_home_view_body.dart';

class ChefHomeView extends StatelessWidget {
  const ChefHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChefHomeCubit(
        databaseService: getIt.get<DatabaseService>(),
        authService: getIt.get<AuthService>(),
      )..getChefData()..getChefRecipes(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.wb_sunny_outlined,
                    color: Color(0xff4D8194),
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

            ],
          ),
        ),
        body: const ChefHomeViewBody(),
      ),
    );
  }
}
