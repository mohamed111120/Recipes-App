import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/auth_service.dart';
import 'core/services/database_service.dart';
import 'core/services/media_service.dart';
import 'core/services/register_service.dart';
import 'core/services/storage_service.dart';
import 'core/utils/helper_functions/first_screen.dart';
import 'features/chef_recipes/manger/chef_recipes_cubit.dart';
import 'features/splash/view/splash_view.dart';

class FoodRecipes extends StatelessWidget {
  const FoodRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChefRecipesCubit(
        databaseService: getIt.get<DatabaseService>(),
        storageService: getIt.get<StorageService>(),
        authService: getIt.get<AuthService>(),
        mediaService: getIt.get<MediaService>(),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            color: Colors.transparent,
          ),
        ),
        home: FutureBuilder(
          future: firstScreen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return snapshot.data ?? const SplashView();
            }
          },
        ),
      ),
    );
  }
}
