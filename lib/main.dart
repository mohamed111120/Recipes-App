import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_recipes/app.dart';
import 'bloc_observer.dart';
import 'core/services/cache/shered_manager.dart';
import 'core/services/register_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedService.init();
  registerService();
  Bloc.observer = MyBlocObserver();
  runApp(const FoodRecipes());
}

