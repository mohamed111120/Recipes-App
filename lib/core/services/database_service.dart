import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_recipes/core/services/register_service.dart';
import 'package:food_recipes/main_models/chef_model.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_model.dart';
import '../../main_models/chat_model.dart';
import '../../main_models/message_model.dart';
import '../../main_models/recipe_model/recipe_reviews.dart';
import '../../main_models/recipe_model/recipe_steps_model.dart';
import '../../main_models/user_model.dart';
import 'auth_service.dart';

class DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference? _usersCollection;
  CollectionReference? _chatsCollection;
  CollectionReference? _chefsCollection;
  CollectionReference? _recipesCollection;
  final AuthService _authServices = getIt.get<AuthService>();

  DatabaseService() {
    _setupCollectionReference();
  }

  // _setupCollectionReference
  _setupCollectionReference() {
    _usersCollection = firestore.collection('users').withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (userModel, _) {
        return userModel.toJson();
      },
    );

    _chatsCollection = firestore.collection('chats').withConverter<ChatModel>(
      fromFirestore: (snapshot, _) {
        return ChatModel.fromJson(snapshot.data()!);
      },
      toFirestore: (chatModel, _) {
        return chatModel.toJson();
      },
    );
    _chefsCollection = firestore.collection('chefs').withConverter<ChefModel>(
      fromFirestore: (snapshot, _) {
        return ChefModel.fromJson(snapshot.data()!);
      },
      toFirestore: (chefModel, _) {
        return chefModel.toJson();
      },
    );
    _recipesCollection =
        firestore.collection('recipes').withConverter<RecipeModel>(
      fromFirestore: (snapshot, _) {
        return RecipeModel.fromJson(snapshot.data()!);
      },
      toFirestore: (recipeModel, _) {
        return recipeModel.toJson();
      },
    );
  }

  // createUserProfile
  Future<void> createUserProfile({
    required UserModel userModel,
  }) async {
    await _usersCollection!.doc(userModel.uid).set(userModel);
  }

  // createChefProfile
  Future<void> createChefProfile({
    required ChefModel chefModel,
  }) async {
    await _chefsCollection!.doc(chefModel.uid).set(chefModel);
  }

  // createRecipe
  Future<void> createRecipe({
    required RecipeModel recipeModel,
  }) async {
    try {
      await _recipesCollection!.add(recipeModel).then(
        (value) {
          _recipesCollection!.doc(value.id).update({'recipe id': value.id});
        },
      );
    } on Exception catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteRecipe({required String recipeId}) async {
    await _recipesCollection!.doc(recipeId).delete();
  }

  Future<void> deleteFromFavorites({required String recipeId}) async {
    await _usersCollection!.doc(_authServices.uid).update({
      'favoriteRecipes': FieldValue.arrayRemove([recipeId])
    });
  }

  // getUserProfile
  Stream<QuerySnapshot<UserModel>> getAllUsers() {
    return _usersCollection?.snapshots() as Stream<QuerySnapshot<UserModel>>;
  }

  Stream<QuerySnapshot<ChefModel>> getAllChefs() {
    return _chefsCollection?.snapshots() as Stream<QuerySnapshot<ChefModel>>;
  }

  // generateChatId
  String generateChatId({required String uid1, required String uid2}) {
    List<String> uIds = [uid1, uid2];
    uIds.sort();
    String chatId = uIds.fold(
      '',
      (id, uid) => '$id$uid',
    );
    return chatId;
  }

  // checkChatExist
  Future<bool> checkChatExist(
      {required String uid1, required String uid2}) async {
    String chatId = generateChatId(uid1: uid1, uid2: uid2);
    final result = await _chatsCollection?.doc(chatId).get();
    if (result != null) {
      return result.exists;
    }
    return false;
  }

  // createNewChat
  Future<void> createNewChat(
      {required String uid1, required String uid2}) async {
    String chatId = generateChatId(uid1: uid1, uid2: uid2);
    final docRef = _chatsCollection!.doc(chatId);
    final chatModel = ChatModel(
      id: chatId,
      participants: [uid1, uid2],
      messages: [],
    );
    await docRef.set(chatModel);
  }

  // sendChatMessage
  Future<void> sendChatMessage({
    required String uid1,
    required String uid2,
    required MessageModel message,
  }) async {
    String chatId = generateChatId(uid1: uid1, uid2: uid2);
    final docRef = _chatsCollection!.doc(chatId);
    await docRef.update({
      'messages': FieldValue.arrayUnion(
        [
          message.toJson(),
        ],
      ),
    });
  }

  // getChatData
  Stream<DocumentSnapshot<ChatModel>> getChatData({
    required String uid1,
    required String uid2,
  }) {
    String chatId = generateChatId(uid1: uid1, uid2: uid2);
    return _chatsCollection!.doc(chatId).snapshots()
        as Stream<DocumentSnapshot<ChatModel>>;
  }

  Stream<QuerySnapshot<RecipeModel>> getFeaturedRecipes() {
    return _recipesCollection!.where('is featured', isEqualTo: true).snapshots()
        as Stream<QuerySnapshot<RecipeModel>>;
  }

  Stream<QuerySnapshot<ChefModel?>> getSingleChefs(String chefId) {
    return _chefsCollection!.where('uid', isEqualTo: chefId).snapshots()
        as Stream<QuerySnapshot<ChefModel?>>;
  }

  Future<DocumentSnapshot<ChefModel?>> getChef(String chefId) {
    return _chefsCollection!.doc(chefId).get()
        as Future<DocumentSnapshot<ChefModel?>>;
  }

  Future<DocumentSnapshot<UserModel?>> getUser(String userId) {
    return _usersCollection!.doc(userId).get()
        as Future<DocumentSnapshot<UserModel?>>;
  }

  Future<UserModel> getCurrentUser(String userid) async {
    var result = await _usersCollection!.where('uid', isEqualTo: userid).get();
    UserModel currentUser = result.docs.first.data() as UserModel;
    print(currentUser.name);
    return currentUser;
  }

  Future<void> updateRecipeCount(String recipeId) async {
    await _recipesCollection!.doc(recipeId).update(
      {
        'click count': FieldValue.increment(
          1,
        )
      },
    );
  }

  Stream<QuerySnapshot<RecipeModel?>>? getPopularRecipes() {
    return _recipesCollection?.snapshots()
        as Stream<QuerySnapshot<RecipeModel>>;
  }

  Future<QuerySnapshot<RecipeModel?>> getChefRecipes(String chefId) {
    return _recipesCollection!.where('chef uid', isEqualTo: chefId).get()
        as Future<QuerySnapshot<RecipeModel?>>;
  }

  Future<void> rateRecipe({
    required String recipeId,
    required RecipeReviews recipeReview,
  }) async {
    await _recipesCollection!.doc(recipeId).update(
      {
        'recipe reviews': FieldValue.arrayUnion(
          [
            recipeReview.toJson(),
          ],
        ),
      },
    );
  }

  Stream<DocumentSnapshot<RecipeModel>> getRecipeReviews(
      {required String recipeId}) {
    return _recipesCollection!.doc(recipeId).snapshots()
        as Stream<DocumentSnapshot<RecipeModel>>;
  }

  Future<QuerySnapshot<RecipeModel>> getRecipesByCategory(String category) {
    return _recipesCollection!.where('category', isEqualTo: category).get()
        as Future<QuerySnapshot<RecipeModel>>;
  }

  addToFavourites({required String recipeId, required String userId}) async {
    await _usersCollection!.doc(userId).update({
      'favoriteRecipes': FieldValue.arrayUnion(
        [recipeId],
      )
    });
  }

  deleteFromFavourites(
      {required String recipeId, required String userId}) async {
    await _usersCollection!.doc(userId).update({
      'favoriteRecipes': FieldValue.arrayRemove(
        [recipeId],
      )
    });
  }

  Future<bool?> isRecipeFavourite(
      {required String recipeId, required String userId}) async {
    DocumentSnapshot<UserModel> user = await _usersCollection!.doc(userId).get()
        as DocumentSnapshot<UserModel>;
    return user.data()!.favoriteRecipes?.contains(recipeId);
  }

  Future<List<String>?> getFavoritesRecipes({required String userId}) async {
    DocumentSnapshot<UserModel> user = await _usersCollection!.doc(userId).get()
        as DocumentSnapshot<UserModel>;
    return user.data()!.favoriteRecipes;
  }

  Future<RecipeModel?> getRecipe({required String recipeId}) async {
    DocumentSnapshot<RecipeModel?> recipe = await _recipesCollection!
        .doc(recipeId)
        .get() as DocumentSnapshot<RecipeModel?>;
    return recipe.data();
  }

  editRecipe({
    required String recipeId,
    required String recipeName,
    required String recipeDescription,
    required String category,
    required String features,
    required int recipeTime,
    required List<RecipeSteps> recipeSteps,
  }) async {
    await _recipesCollection!.doc(recipeId).update({
      'recipe name': recipeName,
      'recipe description': recipeDescription,
      'recipe steps': recipeSteps.map(
        (e) => e.toJson(),
      ),
      'category': category,
      'features': features,
      'recipe time': recipeTime,
    });
  }
}
