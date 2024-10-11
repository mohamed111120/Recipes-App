import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/utils/helper_functions/check_is_user_function.dart';
import 'package:meta/meta.dart';

import '../../../../../core/constants/shared_keys.dart';
import '../../../../../core/services/auth_service.dart';
import '../../../../../core/services/cache/shered_manager.dart';
import '../../../../../core/services/database_service.dart';

part 'user_login_state.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit({required this.authService, required this.databaseService})
      : super(UserLoginInitial());
  static UserLoginCubit get(context) => BlocProvider.of(context);
  final AuthService authService;
  final DatabaseService databaseService;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  Future<void> userLogin() async {
    emit(UserLoginLoading());

    try {
    var result =  await authService.login(
        email: emailController.text,
        password: passwordController.text,
      );
    if (result) {
      bool? isUser = await checkISUser(authService.uid);
      if (isUser) {
        SharedService.set(key: SharedKeys.uid, value: authService.uid);
        emit(UserLoginSuccess());
      } else {
        await authService.logout();
        SharedService.remove(key: SharedKeys.uid);
        emit(UserLoginError(error: 'You are not a user'));
      }
    }

    } on FirebaseAuthException catch (e) {
      emit(UserLoginError(error: e.toString()));
    }
  }
}
