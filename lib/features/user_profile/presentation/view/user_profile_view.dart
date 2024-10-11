import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/constants/shared_keys.dart';
import 'package:food_recipes/core/services/cache/shered_manager.dart';
import 'package:food_recipes/features/splash/view/splash_view.dart';
import 'package:food_recipes/features/user_profile/presentation/widgets/user_profile_view_body.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/media_service.dart';
import '../../../../core/services/register_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../manager/user_profile_cubit.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      UserProfileCubit(
        databaseService: getIt.get<DatabaseService>(),
        authService: getIt.get<AuthService>(),
        storageService: getIt.get<StorageService>(),
        mediaService: getIt.get<MediaService>(),
      )
        ..getUserProfileData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Profile'),
          actions: [
            BlocConsumer<UserProfileCubit, UserProfileState>(
              listener: (context, state) {
                if (state is UserSignOutSuccess) {
                  SharedService.remove(key: SharedKeys.uid);
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
                return IconButton(
                  icon: const Icon(Icons.logout_outlined),
                  onPressed: () {
                    BlocProvider.of<UserProfileCubit>(context).signOut();
                  },
                );
              },
            ),
          ],
        ),
        body: const UserProfileViewBody(),
      ),
    );
  }
}
