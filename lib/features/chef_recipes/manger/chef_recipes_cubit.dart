import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/main_models/chef_model.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_steps_model.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/database_service.dart';
import '../../../core/services/media_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../main_models/recipe_model/recipe_model.dart';

part 'chef_recipes_state.dart';

class ChefRecipesCubit extends Cubit<ChefRecipesState> {
  ChefRecipesCubit({
    required this.databaseService,
    required this.authService,
    required this.storageService,
    required this.mediaService,
  }) : super(ChefRecipesInitial());

  static ChefRecipesCubit get(context) => BlocProvider.of(context);
  final DatabaseService databaseService;
  final AuthService authService;
  final StorageService storageService;
  final MediaService mediaService;
  ChefModel? currentChef;
  List<RecipeSteps> recipeSteps = [];
  String? recipeCategory;

  TextEditingController? nameController = TextEditingController();
  TextEditingController? descriptionController = TextEditingController();
  TextEditingController? featuresController = TextEditingController();
  final List<TextEditingController>? stepsTextControllers = [];
  final List<TextEditingController>? minutesTextControllers = [];
  GlobalKey<FormState> editRecipeFormKey = GlobalKey<FormState>();

  initRecipesCubit({
    required String name,
    required String desc,
    required String features,
    required String category,
    required List<RecipeSteps> steps,
  }) {
    nameController?.text = name;
    recipeCategory = category;
    descriptionController?.text = desc;
    featuresController?.text = features;
    stepsTextControllers?.clear();
    minutesTextControllers?.clear();
    for (int i = 0; i < steps.length; i++) {
      TextEditingController step = TextEditingController();
      TextEditingController muinte = TextEditingController();
      step.text = steps[i].step ?? '';
      muinte.text = steps[i].minutes.toString() ?? '';
      stepsTextControllers?.add(step);
      minutesTextControllers?.add(muinte);
    }
  }

  changeRecipeCategory({required String? value}) {
    recipeCategory = value;
    emit(ChangeRecipeCategory());
  }

  Future<void> getChefProfileData() async {
    await databaseService.getChef(authService.uid ?? '').then(
      (value) {
        currentChef = value.data();
      },
    );
    emit(GetCurrentChefProfileData());
  }

  Future<QuerySnapshot<RecipeModel?>> getChefRecipes() {
    return databaseService.getChefRecipes(currentChef?.uid ?? '');
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

  Future<void> deleteRecipe({required String recipeId}) async {
    try {
      await databaseService.deleteRecipe(recipeId: recipeId);
      await getChefRecipes();
      emit(DeleteRecipeSuccess());
    } catch (e) {
      emit(DeleteRecipeError());
    }
  }

  Future<void> editRecipe({
    required String recipeId,
  }) async {
    emit(EditRecipeLoading());
    for (int i = 0; i < stepsTextControllers!.length; i++) {
      recipeSteps.add(
        RecipeSteps(
          step: stepsTextControllers![i].text,
          minutes: int.parse(minutesTextControllers![i].text),
        ),
      );
    }
    Future<int> getRecipeTime() async {
      int recipeTime = 0;
      for (int i = 0; i < recipeSteps.length; i++) {
        recipeTime = recipeSteps[i].minutes! + recipeTime;
      }
      return recipeTime;
    }
    int recipeTime = await getRecipeTime();
    try {
      await databaseService.editRecipe(
        category: recipeCategory!,
        features: featuresController!.text,
        recipeTime: recipeTime,
        recipeSteps: recipeSteps,
        recipeId: recipeId,
        recipeName: nameController!.text,
        recipeDescription: descriptionController!.text,
      );
      emit(EditRecipeSuccess());
      recipeSteps.clear();
    } catch (e) {
      emit(EditRecipeError());
      recipeSteps.clear();
    }
  }
}
