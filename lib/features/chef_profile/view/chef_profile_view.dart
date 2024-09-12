import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/auth_service.dart';
import 'package:food_recipes/core/services/register_service.dart';
import 'package:food_recipes/features/chef_profile/manager/chef_profile_cubit.dart';
import 'package:food_recipes/features/chef_profile/widgets/chef_profile_view_body.dart';
import 'package:food_recipes/features/splash/view/splash_view.dart';

import '../../../core/services/cache/shered_manager.dart';
import '../../../core/services/database_service.dart';
import '../../../core/services/media_service.dart';
import '../../../core/services/storage_service.dart';

class ChefProfileView extends StatelessWidget {
  const ChefProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChefProfileCubit(
        databaseService: getIt.get<DatabaseService>(),
        authService: getIt.get<AuthService>(),
        storageService: getIt.get<StorageService>(),
        mediaService: getIt.get<MediaService>(),
      )..getChefProfileData(),
      child: Builder(builder: (context) {
        return BlocConsumer<ChefProfileCubit, ChefProfileState>(
          listener: (context, state) {
            if (state is ChefSignOutSuccess) {
              SharedService.clear();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashView(),
                ),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            var chefProfileCubit = ChefProfileCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading:  false,
                actions: [
                  IconButton(
                    onPressed: () {
                      chefProfileCubit.signOut();
                    },
                    icon: const Icon(Icons.logout),
                  ),
                ],
              ),
              body: const ChefProfileViewBody(),
            );
          },
        );
      }),
    );
  }
}
