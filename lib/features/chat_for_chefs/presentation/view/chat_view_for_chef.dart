import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/core/services/register_service.dart';
import 'package:food_recipes/features/chat_for_chefs/presentation/widgets/chat_view_body_for_chef.dart';
import 'package:food_recipes/main_models/user_model.dart';
import '../../../../../core/services/auth_service.dart';
import '../../../../../core/services/media_service.dart';
import '../../../../../core/services/storage_service.dart';
import '../../manager/chat_chef_cubit.dart';

class ChatViewForChef extends StatelessWidget {
  const ChatViewForChef({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatChefCubit(
        databaseService: getIt.get<DatabaseService>(),
        authService:  getIt.get<AuthService>(),
        mediaService:  getIt.get<MediaService>(),
        storageService: getIt.get<StorageService>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(user.name ?? ''),
        ),
        body: ChatViewBodyForChef(
          user: user,
        ),
      ),
    );
  }
}
