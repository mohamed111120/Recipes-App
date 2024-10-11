import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/register_service.dart';

import '../../../../core/services/database_service.dart';
import '../../manager/favorites_list_cubit/favorites_list_cubit.dart';
import '../widgets/user_favorirtes_view_body.dart';

class UserFavoritesView extends StatelessWidget {
  const UserFavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesListCubit(
        databaseService: getIt.get<DatabaseService>(),
      )..getUserFavoritesList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Favorites'),
        ),
        body: const UserFavoritesViewBody(),
      ),
    );
  }
}
