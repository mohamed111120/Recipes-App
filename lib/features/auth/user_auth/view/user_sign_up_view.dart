import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/media_service.dart';
import '../../../../core/services/register_service.dart';
import '../../../../core/services/storage_service.dart';
import '../manager/user_sign_up_cubit/user_sign_up_cubit.dart';
import 'widgets/user_sign_up_view_body.dart';

class UserSignUpView extends StatelessWidget {
  const UserSignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserSignUpCubit(
        authService: getIt.get<AuthService>(),
        databaseService: getIt.get<DatabaseService>(),
        storageService: getIt.get<StorageService>(),
        mediaService: getIt.get<MediaService>(),
      ),
      child: Scaffold(
        body: UserSignUpViewBody(),
      ),
    );
  }
}
