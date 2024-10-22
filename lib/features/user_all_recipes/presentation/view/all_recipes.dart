import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/core/services/register_service.dart';
import 'package:food_recipes/features/user_all_recipes/manager/all_recipes_cubit.dart';

import '../widgets/all_recipes_view_body.dart';

class AllRecipes extends StatelessWidget {
  const AllRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllRecipesCubit(
        databaseService: getIt.get<DatabaseService>(),
      )..getAllRecipes(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text("All Recipes"),
            centerTitle: true,
          ),
          body: AllRecipesViewBody()),
    );
  }
}
