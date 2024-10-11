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

class ChefRecipesView extends StatefulWidget {
  const ChefRecipesView({super.key});

  @override
  State<ChefRecipesView> createState() => _ChefRecipesViewState();
}

class _ChefRecipesViewState extends State<ChefRecipesView> {
  @override
  void initState() {
    ChefRecipesCubit.get(context)
      ..getChefProfileData()
      ..getChefRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Your Recipes',
          style: AppTextStyles.bold18.copyWith(color: Colors.black),
        ),
      ),
      body: const ChefRecipesViewBody(),
    );
  }
}
