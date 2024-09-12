import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/auth/chef_auth/manager/chef_login_cubit/chef_login_cubit.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/register_service.dart';
import 'widgets/chef_login_view_body.dart';

class ChefLoginView extends StatelessWidget {
  const ChefLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChefLoginCubit(
        authService: getIt<AuthService>(),
        databaseService: getIt<DatabaseService>(),
      ),
      child: Scaffold(
        body: ChefLoginViewBody(),
      ),
    );
  }
}
