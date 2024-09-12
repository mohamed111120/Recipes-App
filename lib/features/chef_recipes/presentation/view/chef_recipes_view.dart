import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/chef_recipes/presentation/widgets/chef_recipes_view_body.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/media_service.dart';
import '../../../../core/services/register_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../manger/chef_recipes_cubit.dart';

class ChefRecipesView extends StatelessWidget {
  const ChefRecipesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChefRecipesCubit(
        databaseService: getIt.get<DatabaseService>(),
        authService: getIt.get<AuthService>(),
        storageService: getIt.get<StorageService>(),
        mediaService: getIt.get<MediaService>(),
      )..getChefProfileData()..getChefRecipes(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title:  Text('Your Recipes',style: AppTextStyles.bold18.copyWith(color: Colors.black),),
        ),
        body: const ChefRecipesViewBody(),
      ),
    );
  }
}
