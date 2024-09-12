import 'package:flutter/material.dart';
import 'package:food_recipes/features/auth/chef_auth/view/chef_sign_up_view.dart';
import 'package:food_recipes/features/auth/user_auth/view/user_sign_up_view.dart';
import '../../widgets/custom_button.dart';

Future<dynamic> buildAuthShowDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: const Text(
          'Create New Account for ',
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'User',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserSignUpView(),
                        ));
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomButton(
                  text: 'Chef',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChefSignUpView(),
                        ));
                  },
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
