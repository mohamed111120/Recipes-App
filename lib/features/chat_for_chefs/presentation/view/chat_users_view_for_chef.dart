import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/chat_for_chefs/presentation/widgets/chat_users_view_body_for_chef.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/media_service.dart';
import '../../../../core/services/register_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../manager/chat_chef_cubit.dart';

class ChatUsersViewForChef extends StatelessWidget {
  const ChatUsersViewForChef({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatChefCubit(
        databaseService: getIt.get<DatabaseService>(),
        authService: getIt.get<AuthService>(),
        mediaService: getIt.get<MediaService>(),
        storageService: getIt.get<StorageService>(),
      ),
      child:  Scaffold(
        appBar:  AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title:  Text('All Users',style:  AppTextStyles.bold18.copyWith(color: Colors.black),),
        ),
        body: const ChatUsersViewBodyForChef(),
      ),
    );
  }
}
