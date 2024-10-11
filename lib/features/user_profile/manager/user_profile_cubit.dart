import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/main_models/user_model.dart';
import 'package:meta/meta.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/services/database_service.dart';
import '../../../core/services/media_service.dart';
import '../../../core/services/storage_service.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit({
    required this.databaseService,
    required this.authService,
    required this.storageService,
    required this.mediaService,
  }) : super(UserProfileInitial());

  static UserProfileCubit get(context) => BlocProvider.of(context);
  final DatabaseService databaseService;
  final AuthService authService;
  final StorageService storageService;
  final MediaService mediaService;
  UserModel? currentUser;


  getUserProfileData() async {
    await databaseService.getUser(authService.uid ?? '').then(
          (value) {
        currentUser = value.data();
      },
    );
    emit(GetCurrentUserProfileData());
  }

  signOut() async {
    var result = await authService.logout();
    if (result) {
      emit(UserSignOutSuccess());
    } else {
      emit(UserSignOutError());
    }
  }
}
