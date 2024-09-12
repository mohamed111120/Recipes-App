import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/chef_add_recipes/manager/add_recipres_cubit/add_recipes_cubit.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/services/database_service.dart';
import '../../../core/services/media_service.dart';
import '../../../core/services/register_service.dart';
import '../../../core/services/storage_service.dart';
import 'widgets/chef_add_recipes_view_body.dart';

class ChefAddRecipesView extends StatelessWidget {
  const ChefAddRecipesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Add Recipe Page'),
      ),
      body: BlocProvider(
        create: (context) => AddRecipesCubit(
          databaseService: getIt<DatabaseService>(),
          authService: getIt<AuthService>(),
          mediaService: getIt<MediaService>(),
          storageService: getIt<StorageService>(),
        ),
        child: ChefAddRecipesViewBody(),
      ),
    );
  }
}
