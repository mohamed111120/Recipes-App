import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
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
  bool editMode = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

 GlobalKey<FormState> formKey = GlobalKey<FormState>();
  getUserProfileData() async {
    await databaseService.getUser(authService.uid ?? '').then(
      (value) {
        currentUser = value.data();
      },
    );

    nameController.text = currentUser?.name ?? '';
    addressController.text = currentUser?.address ?? '';
    phoneNumberController.text = currentUser?.phoneNumber ?? '';
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

  editProfileMode() {
    editMode = !editMode;
    emit(ChangeEditMode());
  }

  editUserProfile(
      {required String name,
      required String address,
      required String phoneNumber}) async {
    UserModel userModel = currentUser!;
    userModel.name = name;
    userModel.address = address;
    userModel.phoneNumber = phoneNumber;
    try {
      await databaseService.updateUser(userModel: userModel);

      emit(EditProfileSuccess());
    } on Exception catch (e) {
      emit(EditProfileError());
      // TODO
    }
  }
}
