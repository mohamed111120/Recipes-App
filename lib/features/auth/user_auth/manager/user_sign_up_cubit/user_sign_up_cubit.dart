import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/constants/shared_keys.dart';
import 'package:food_recipes/core/services/auth_service.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/core/services/media_service.dart';
import 'package:food_recipes/core/services/storage_service.dart';
import '../../../../../core/services/cache/shered_manager.dart';
import '../../../../../main_models/user_model.dart';

part 'user_sign_up_state.dart';

class UserSignUpCubit extends Cubit<UserSignUpState> {
  UserSignUpCubit({
    required this.authService,
    required this.databaseService,
    required this.storageService,
    required this.mediaService,
  }) : super(UserSignUpInitial());

  static UserSignUpCubit get(context) => BlocProvider.of(context);

  final AuthService authService;
  final DatabaseService databaseService;
  final StorageService storageService;
  final MediaService mediaService;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? nameController = TextEditingController();
  TextEditingController? phoneNumberController = TextEditingController();
  TextEditingController? addressController = TextEditingController();
  File? userImageFile;
  String? userImageUrl;

  Future<void> userSignUp() async {
    emit(UserSignUpLoading());
    try {
     await authService.signUp(
        email: emailController?.text ?? '',
        password: passwordController?.text ?? '',
        name: nameController?.text ?? '',
      );
     if (userImageFile != null) {
       await uploadUserImage(image: userImageFile!);
     }
      await createUserProfile(
        userModel: UserModel(
        uid: authService.uid,
        name: nameController?.text ?? '',
        email: emailController?.text ?? '',
        phoneNumber: phoneNumberController?.text ?? '',
        address: addressController?.text ?? '',
        photoUrl: userImageUrl ?? '',
        ),
      );
      SharedService.set(key: SharedKeys.uid, value: authService.uid);
      emit(UserSignUpSuccess());
    } on FirebaseAuthException catch (e) {
      log(e.code);
      emit(UserSignUpError(error: e.code));
    } catch (e) {
      log(e.toString());
      emit(
        UserSignUpError(error: e.toString()),
      );
    }
  }

  Future<void> createUserProfile({
    required UserModel userModel,
  }) async {
    await databaseService.createUserProfile(
      userModel: userModel,
    );
  }

  Future<File?> getImageFromGallary() async {
    userImageFile = await mediaService.getImageFromGallary();
    emit(GetImageFromGallery());
    return userImageFile;
  }

  Future<String?> uploadUserImage({required File image}) async {
    emit(UploadUserImageLoading());
    try {
      userImageUrl = await storageService.uploadUserImage(
          imageFile: userImageFile!, uid: authService.uid!);
      emit(UploadUserImageSuccess());
    } on Exception catch (e) {
      // TODO
      emit(UploadUserImageError());
    }
    return userImageUrl;
  }
}
