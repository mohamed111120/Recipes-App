import 'package:flutter/material.dart';
import 'package:food_recipes/core/utils/helper_functions/check_is_user_function.dart';
import 'package:food_recipes/features/chef_home_layout/chef_home_layout.dart';
import 'package:food_recipes/features/user_home_layout/user_home_layout_view.dart';

import '../../../features/splash/view/splash_view.dart';
import '../../constants/shared_keys.dart';
import '../../services/cache/shered_manager.dart';
import 'check_is_chef_function.dart';

Future<Widget?> firstScreen() async {
  var uid = SharedService.get(key: SharedKeys.uid);
  bool isChef = await checkISChef(uid);
  bool isUser = await checkISUser(uid);
  if (uid == null) {
    return const SplashView();
  } else if (isChef) {
    return const ChefHomeLayoutView();
  } else if(isUser) {
    return const UserHomeLayoutView();
  }else{
    SharedService.remove(key: SharedKeys.uid);
    return const SplashView();
  }
}
