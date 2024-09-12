import 'dart:developer';
import 'dart:io';
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
import '../../../../../main_models/chef_model.dart';

part 'chef_sign_up_state.dart';

class ChefSignUpCubit extends Cubit<ChefSignUpState> {
  ChefSignUpCubit({
    required this.databaseService,
    required this.authService,
    required this.storageService,
    required this.mediaService,
  }) : super(ChefSignUpInitial());

  static ChefSignUpCubit get(context) => BlocProvider.of(context);

  final DatabaseService databaseService;
  final MediaService mediaService;
  final AuthService authService;
  final StorageService storageService;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? nameController = TextEditingController();
  TextEditingController? phoneNumberController = TextEditingController();
  TextEditingController? addressController = TextEditingController();
  TextEditingController? photoUrlController = TextEditingController();
  TextEditingController? yearsOfExperience = TextEditingController();
  File? chefImageFile;
  String? chefImageUrl;

  Future<void> chefSignUp() async {
    emit(ChefSignUpLoading());
    try {
      await authService.signUp(
        email: emailController?.text ?? '',
        password: passwordController?.text ?? '',
        name: nameController?.text ?? '',
      );
      if (chefImageFile != null) {
        await uploadChefImage(
          image: chefImageFile!,
        );
      }
      await createChefProfile(
        chefModel: ChefModel(
          name: nameController?.text ?? '',
          email: emailController?.text ?? '',
          uid: authService.uid,
          photoUrl: chefImageUrl,
          phoneNumber: phoneNumberController?.text ?? '',
          address: addressController?.text ?? '',
          yearsOfExperience: int.parse(
            yearsOfExperience?.text ?? '0',
          ),
        ),
      );

      SharedService.set(key: SharedKeys.uid, value: authService.uid);
      emit(ChefSignUpSuccess());
    } on FirebaseAuthException catch (e) {
      log(e.code);
      emit(ChefSignUpError(error: e.code));
    } catch (e) {
      log(e.toString());
      emit(
        ChefSignUpError(error: e.toString()),
      );
    }
  }

  Future<void> createChefProfile({required ChefModel chefModel}) async {
    await databaseService.createChefProfile(
      chefModel: chefModel,
    );
  }

  Future<File?> getImageFromGallary() async {
    chefImageFile = await mediaService.getImageFromGallary();
    emit(GetImageFromGallery());
    return chefImageFile;
  }

  Future<String?> uploadChefImage({required File image}) async {
    emit(UploadChefImageLoading());
    try {
      chefImageUrl = await storageService.uploadChefImage(
          imageFile: chefImageFile!, uid: authService.uid!);
      emit(UploadChefImageSuccess());
    } on Exception catch (e) {
      // TODO
      emit(UploadChefImageError());
    }
    return chefImageUrl;
  }
}
