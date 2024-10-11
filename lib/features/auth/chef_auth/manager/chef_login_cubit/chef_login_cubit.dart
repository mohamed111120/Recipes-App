import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/auth_service.dart';
import 'package:food_recipes/core/services/database_service.dart';
import '../../../../../core/constants/shared_keys.dart';
import '../../../../../core/services/cache/shered_manager.dart';
import '../../../../../core/utils/helper_functions/check_is_chef_function.dart';
import '../../../../../core/utils/helper_functions/check_is_user_function.dart';

part 'chef_login_state.dart';

class ChefLoginCubit extends Cubit<ChefLoginState> {
  ChefLoginCubit({required this.authService,required this.databaseService}) : super(ChefLoginInitial());

  static ChefLoginCubit get(context) => BlocProvider.of(context);

  final AuthService authService;
  final DatabaseService databaseService;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  Future<void> chefLogin() async {
    emit(ChefLoginLoading());
    try {
   await authService.login(
        email: emailController.text,
        password: passwordController.text,
    );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(ChefLoginError(error: 'user-not-found'));
      } else if (e.code == 'wrong-password') {
        emit(ChefLoginError(error: 'wrong-password'));
      } else if (e.code == 'invalid-email') {
        emit(ChefLoginError(error: 'invalid-email'));
      } else {
        emit(ChefLoginError(error: e.toString()));
      }

    }
      bool? isChef = await checkISChef( authService.uid);
      bool? isUser = await checkISUser( authService.uid);
      if (isChef ) {
        SharedService.set(key: SharedKeys.uid, value: authService.uid);
        emit(ChefLoginSuccess());
      } else if(isUser) {
        await authService.logout();
        SharedService.remove(key: SharedKeys.uid);
        emit(ChefLoginError(error: 'You are not a chef'));
      }

  }
}
