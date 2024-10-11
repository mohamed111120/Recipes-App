import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate/rate.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/register_service.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../main_models/recipe_model/recipe_model.dart';
import '../../manager/rate_recipe_cubit/rate_recipe_cubit.dart';

class RateRecipeButton extends StatelessWidget {
  const RateRecipeButton({super.key, required this.recipeModel});
  final RecipeModel recipeModel;
  @override
  Widget build(BuildContext context) {
    return CustomButton(
        text: 'Rate This Recipe',
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return BlocProvider(
                create: (context) => RateRecipeCubit(
                  databaseService: getIt.get<DatabaseService>(),
                  authServices: getIt.get<AuthService>(),
                ),
                child: AlertDialog(
                  title: Text(
                    textAlign: TextAlign.center,
                    'Rate this recipe',
                    style: AppTextStyles.bold18.copyWith(
                        color: AppColors.secondaryColor),
                  ),
                  content: Builder(builder: (context) {
                    return Form(
                      key: RateRecipeCubit.get(context).formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Rate(
                            allowHalf: true,
                            iconSize: 40,
                            color: AppColors.primaryColor,
                            initialValue: 3,
                            onChange: (value) {
                              RateRecipeCubit.get(context).rating =
                                  value.toInt();
                            },
                          ),
                          const SizedBox(height: 8),
                          CustomTextFormField(
                            controller: RateRecipeCubit.get(context)
                                .contentController,
                            hintText: 'Enter your review',
                          ),
                          const SizedBox(height: 8),
                          BlocListener<RateRecipeCubit,
                              RateRecipeState>(
                            listener: (context, state) {
                              if (state is UserRecipeRatedSuccess) {
                                Navigator.pop(context);
                              }
                            },
                            child: CustomButton(
                              text: 'Submit',
                              onTap: () async {
                                RateRecipeCubit.get(context)
                                    .rateRecipe(
                                    recipeId:
                                    recipeModel.recipeId ??
                                        '');
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              );
            },
          );
        });
  }
}
