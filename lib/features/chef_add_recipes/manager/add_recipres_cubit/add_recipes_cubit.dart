import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/auth_service.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/core/services/media_service.dart';
import 'package:food_recipes/core/services/storage_service.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_model.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_steps_model.dart';

part 'add_recipes_state.dart';

class AddRecipesCubit extends Cubit<AddRecipesState> {
  AddRecipesCubit({
    required this.authService,
    required this.databaseService,
    required this.mediaService,
    required this.storageService,
  }) : super(AddRecipesInitial());

  static AddRecipesCubit get(context) => BlocProvider.of(context);
  final DatabaseService databaseService;
  final AuthService authService;
  final MediaService mediaService;
  final StorageService storageService;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController featuresController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  String? recipeCategory;

  TextEditingController nameController = TextEditingController();
  File? recipeImageFile;
  String? recipeImageUrl;
  List<RecipeSteps> recipeSteps = [];
  bool isFeatured = false;
  final List<TextEditingController>? stepsTextControllers = [
    TextEditingController(),
  ];
  final List<TextEditingController>? minutesTextControllers = [
    TextEditingController(),
  ];

  // final int textEditingControllerIndex = 0;
  changeRecipeCategory(String? value) {
    recipeCategory = value;
    emit(ChangeRecipeCategory());
  }

  addRecipesInput() {
    stepsTextControllers?.add(TextEditingController());
    minutesTextControllers?.add(TextEditingController());
    emit(AddAnotherStep());
  }

  removeRecipesInput() {
    stepsTextControllers?.removeLast();
    minutesTextControllers?.removeLast();
    emit(RemoveLastStep());
  }

  Future<void> getAllRecipeSteps() async {
    recipeSteps = [];
    if (stepsTextControllers?.length == minutesTextControllers?.length) {
      for (int i = 0; i < stepsTextControllers!.length; i++) {
        recipeSteps.add(
          RecipeSteps(
            step: stepsTextControllers?[i].text ?? '',
            minutes: int.parse(minutesTextControllers?[i].text ?? '0'),
          ),
        );
      }
    }
  }

  makeRecipeFeatured() {
    isFeatured = true;
    emit(MakeFeatured());
  }

  Future<int> getRecipeTime() async {
    int recipeTime = 0;
    for (int i = 0; i < recipeSteps.length; i++) {
      recipeTime = recipeSteps[i].minutes! + recipeTime;
    }
    return recipeTime;
  }

  Future<void> submitYourRecipe() async {
    emit(SubmitRecipeLoading());
    await getAllRecipeSteps();
    int recipeTime = await getRecipeTime();
    try {
      RecipeModel recipe = RecipeModel(
        chefUid: authService.uid,
        recipeDescription: descriptionController.text,
        recipeName: nameController.text,
        recipePhoto: recipeImageUrl ?? '',
        recipeSteps: recipeSteps,
        recipeTime: recipeTime,
        isFeatured: isFeatured,
        clickCount: 0,
        recipeReviews: [],
        category: recipeCategory,
        features: featuresController.text,
        calories: int.parse(caloriesController.text),
      );
      await databaseService.createRecipe(recipeModel: recipe);
      isFeatured = false;
      emit(SubmitRecipeSuccess());
    } on Exception catch (e) {
      emit(SubmitRecipeError());
      // TODO
    } catch (e) {
      emit(SubmitRecipeError());
    }
  }

  Future<File?> getImageFromGallary() async {
    recipeImageFile = await mediaService.getImageFromGallary();
    return recipeImageFile;
  }

  Future<String?> uploadRecipeImage(File image) async {
    emit(UploadRecipeImageLoading());
    try {
      recipeImageUrl = await storageService.uploadRecipeImage(
        imageFile: recipeImageFile!,
      );
      emit(UploadRecipeImageSuccess());
    } on Exception catch (e) {
      // TODO
      emit(UploadRecipeImageError());
    }
    return recipeImageUrl;
  }
}
