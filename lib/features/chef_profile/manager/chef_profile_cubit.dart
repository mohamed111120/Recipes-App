import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/auth_service.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/core/services/media_service.dart';
import 'package:food_recipes/core/services/storage_service.dart';
import 'package:meta/meta.dart';

import '../../../main_models/chef_model.dart';
import '../../../main_models/recipe_model/recipe_model.dart';

part 'chef_profile_state.dart';

class ChefProfileCubit extends Cubit<ChefProfileState> {
  ChefProfileCubit({
    required this.databaseService,
    required this.authService,
    required this.storageService,
    required this.mediaService,
  }) : super(ChefProfileInitial());

  static ChefProfileCubit get(context) => BlocProvider.of(context);
  final DatabaseService databaseService;
  final AuthService authService;
  final StorageService storageService;
  final MediaService mediaService;
  ChefModel? currentChef;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController yearsOfExperienceController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool editMode = false;


  editProfileMode() {
    editMode = !editMode;
    emit(ChangeEditMode());
  }


  getChefProfileData() async {
    await databaseService.getChef(authService.uid ?? '').then(
      (value) {
        currentChef = value.data();
      },
    );

    nameController.text = currentChef?.name ?? '';
    addressController.text = currentChef?.address ?? '';
    phoneNumberController.text = currentChef?.phoneNumber ?? '';
    yearsOfExperienceController.text = currentChef?.yearsOfExperience.toString() ?? '';
    emit(GetCurrentChefProfileData());
  }

  signOut() async {
    var result = await authService.logout();
    if (result) {
      emit(ChefSignOutSuccess());
    } else {
      emit(ChefSignOutError());
    }
  }

  Future<QuerySnapshot<RecipeModel?>> getChefRecipes() {

     return databaseService.getChefRecipes(currentChef?.uid ?? '');

  }
  editChefProfile(
      {required String name,
        required String address,
        required String phoneNumber,
        required String yearsOfExperience,
      }) async {
    ChefModel chefModel = currentChef!;
    chefModel.name = name;
    chefModel.address = address;
    chefModel.phoneNumber = phoneNumber;
    chefModel.yearsOfExperience = int.parse(yearsOfExperience);
    try {

      await databaseService.updateChef(chefModel: chefModel);

      emit(EditProfileSuccess());
    } on Exception catch (e) {

      emit(EditProfileError());
      // TODO
    }
  }
}
