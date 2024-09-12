import 'package:flutter/material.dart';
import 'package:food_recipes/core/constants/shared_keys.dart';
import 'package:food_recipes/core/services/cache/shered_manager.dart';
import 'package:food_recipes/features/splash/view/splash_view.dart';
import 'package:food_recipes/features/user_profile/presentation/widgets/user_profile_view_body.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () {
              SharedService.remove(key: SharedKeys.uid);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashView(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: const UserProfileViewBody(),
    );
  }
}
