import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/main_models/chef_model.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_model.dart';
import 'package:meta/meta.dart';

import '../../../../core/services/database_service.dart';
import '../../../../main_models/recipe_model/recipe_reviews.dart';
import '../../../../main_models/user_model.dart';

part 'recipe_reviews_state.dart';

class RecipeReviewsCubit extends Cubit<RecipeReviewsState> {
  RecipeReviewsCubit({
    required this.databaseService,
  }) : super(RecipeReviewsInitial());

  static RecipeReviewsCubit get(context) => BlocProvider.of(context);
  final DatabaseService databaseService;
  bool? isFavorite = false;

  Stream<DocumentSnapshot<RecipeModel>> getRecipeReviews(
      {required String recipeId}) {
    return databaseService.getRecipeReviews(recipeId: recipeId);
  }

  Future<DocumentSnapshot<UserModel?>> getUser({required String userId}) async {
    return databaseService.getUser(
      userId,
    );
  }

}
