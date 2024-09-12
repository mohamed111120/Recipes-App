import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/auth_service.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/core/services/register_service.dart';
import '../../../../core/services/media_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../manager/chat_user_cubit.dart';
import '../widgets/chat_users_view_body_for_user.dart';

class ChatUsersViewForUser extends StatelessWidget {
  const ChatUsersViewForUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatUserCubit(
        databaseService: getIt.get<DatabaseService>(),
        authService: getIt.get<AuthService>(),
        mediaService: getIt.get<MediaService>(),
        storageService: getIt.get<StorageService>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title:  Text('All Chefs',style:  AppTextStyles.bold18.copyWith(color: Colors.black),),

        ),
        body: ChatUsersViewBodyForUser(),
      ),
    );
  }
}
