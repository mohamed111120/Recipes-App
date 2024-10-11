import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/auth_service.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_reviews.dart';

part 'rate_recipe_state.dart';

class RateRecipeCubit extends Cubit<RateRecipeState> {
  RateRecipeCubit({
    required this.databaseService,
    required this.authServices,
  }) : super(UserRecipeInitial());

  static RateRecipeCubit get(context) => BlocProvider.of(context);
  final DatabaseService databaseService;
  final AuthService authServices;
  TextEditingController contentController = TextEditingController();
  int rating = 3;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> rateRecipe({required String recipeId}) async {
    try {
      await databaseService.rateRecipe(
        recipeReview: RecipeReviews(
          userUid: authServices.uid,
          review: contentController.text,
          rating: rating,
          date: DateTime.now().toString(),
        ),
        recipeId: recipeId,
      );
      emit(UserRecipeRatedSuccess());
    }  catch (e) {
      emit(UserRecipeRatedError());
    }
  }
}
