import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/utils/helper_functions/first_screen.dart';
import 'features/splash/view/splash_view.dart';

class FoodRecipes extends StatelessWidget {
  const FoodRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          color: Colors.transparent,
        ),
      ),
      home: FutureBuilder(
        future: firstScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return snapshot.data ?? const SplashView();
          }
        },
      ),
    );
  }
}
