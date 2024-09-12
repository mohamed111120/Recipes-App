import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/core/services/register_service.dart';
import 'package:food_recipes/features/chat_For_User/manager/chat_user_cubit.dart';
import 'package:food_recipes/main_models/chef_model.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/services/media_service.dart';
import '../../../../core/services/storage_service.dart';
import '../widgets/chat_view_body_for_user.dart';

class ChatViewForUser extends StatelessWidget {
  const ChatViewForUser({super.key, required this.chef});

  final ChefModel chef;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatUserCubit(
        databaseService: getIt.get<DatabaseService>(),
        authService:  getIt.get<AuthService>(),
        mediaService:  getIt.get<MediaService>(),
        storageService: getIt.get<StorageService>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(chef.name ?? ''),
        ),
        body: ChatViewBodyForUser(
          chef: chef,
        ),
      ),
    );
  }
}
