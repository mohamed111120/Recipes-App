import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipes/core/constants/app_colors.dart';
import 'package:food_recipes/core/services/payment_service.dart';
import 'package:food_recipes/features/user_home/view/user_home_view.dart';
import '../chat_For_User/presentation/view/chat_users_view_for_user.dart';
import '../user_favorites/presentation/view/user_favoriets_view.dart';
import '../user_profile/presentation/view/user_profile_view.dart';
import 'widgits/user_home_layout_bottom_nav_bar_chef_icon.dart';

class UserHomeLayoutView extends StatefulWidget {
  const UserHomeLayoutView({super.key});

  @override
  State<UserHomeLayoutView> createState() => _UserHomeLayoutViewState();
}

List<Widget> screens = [
  const UserHomeView(),
  const UserFavoritesView(),
  const ChatUsersViewForUser(),
  const UserProfileView(),
];
int selectedIndex = 0;

class _UserHomeLayoutViewState extends State<UserHomeLayoutView> {
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
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColors.primaryColor,
                      size: 30,
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
                      selectedIndex == 2 ? Icons.chat : Icons.chat_outlined,
                      color: AppColors.primaryColor,
                      size: 30,
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
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
