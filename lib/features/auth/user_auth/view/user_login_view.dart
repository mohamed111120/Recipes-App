import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/auth/chef_auth/manager/chef_login_cubit/chef_login_cubit.dart';
import 'package:food_recipes/features/auth/user_auth/view/widgets/user_login_view_body.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/register_service.dart';
import '../manager/user_login_cubit/user_login_cubit.dart';

class UserLoginView extends StatelessWidget {
  const UserLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserLoginCubit(
        authService: getIt<AuthService>(),
        databaseService: getIt<DatabaseService>(),
      ),
      child: Scaffold(
        body: UserLoginViewBody(),
      ),
    );
  }
}
