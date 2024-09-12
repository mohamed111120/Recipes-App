import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipes/core/constants/app_colors.dart';

import '../chat_for_chefs/presentation/view/chat_users_view_for_chef.dart';
import '../chef_home/view/chef_home_view.dart';
import '../chef_profile/view/chef_profile_view.dart';
import '../chef_recipes/presentation/view/chef_recipes_view.dart';
import '../user_home_layout/widgits/user_home_layout_bottom_nav_bar_chef_icon.dart';

class ChefHomeLayoutView extends StatefulWidget {
  const ChefHomeLayoutView({super.key});

  @override
  State<ChefHomeLayoutView> createState() => _ChefHomeLayoutViewState();
}

List<Widget> screens = [
  const ChefHomeView(),
  const ChefRecipesView(),
  const ChatUsersViewForChef(),
  const ChefProfileView(),
];
int selectedIndex = 0;

class _ChefHomeLayoutViewState extends State<ChefHomeLayoutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          Material(
            color: Colors.white,
            elevation: 20,
            child: SizedBox(
              height: 75,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    child: Icon(
                      selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    child: Icon(
                      // TODO change icon
                      selectedIndex == 1
                          ? Icons.fastfood
                          : Icons.fastfood_outlined,
                      color: AppColors.primaryColor,
                      size: 27,
                    ),
                  ),
                  const SizedBox(width: 70),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                    child: Icon(
                      selectedIndex == 2
                          ? Icons.chat
                          : Icons.chat_outlined,
                      color: AppColors.primaryColor,
                      size: 27,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 3;
                      });
                    },
                    child: Icon(
                      selectedIndex == 3 ? Icons.person : Icons.person_outline,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
           Positioned(
            top: -35,
            left: 0,
            right: 0,
            child: BottomNavBarChefIcon(
            ),
          ),
        ],
      ),
    );
  }
}
