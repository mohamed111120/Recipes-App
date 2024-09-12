import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/auth/chef_auth/manager/chef_sign_up_cubit/chef_sign_up_cubit.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/media_service.dart';
import '../../../../core/services/register_service.dart';
import '../../../../core/services/storage_service.dart';
import 'widgets/chef_sign_up_view_body.dart';


class ChefSignUpView extends StatelessWidget {
  const ChefSignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChefSignUpCubit(
        authService: getIt.get<AuthService>(),
        databaseService: getIt.get<DatabaseService>(),
        storageService: getIt.get<StorageService>(),
        mediaService: getIt.get<MediaService>(),
      ),
      child: const Scaffold(
        body: ChefSignUpViewBody(),
      ),
    );
  }
}
