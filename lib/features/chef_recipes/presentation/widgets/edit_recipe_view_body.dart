import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/constants/app_colors.dart';
import 'package:food_recipes/core/widgets/custom_button.dart';
import 'package:food_recipes/core/widgets/custom_text_form_field.dart';
import 'package:food_recipes/features/chef_recipes/presentation/widgets/drop_down_select_category.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../main_models/recipe_model/recipe_model.dart';
import '../../manger/chef_recipes_cubit.dart';
import 'edit_recipe_steps_list_view.dart';

class EditRecipeViewBody extends StatefulWidget {
  const EditRecipeViewBody({super.key, required this.recipeModel});

  final RecipeModel recipeModel;

  @override
  State<EditRecipeViewBody> createState() => _EditRecipeViewBodyState();
}

class _EditRecipeViewBodyState extends State<EditRecipeViewBody> {
  @override
  void initState() {
    ChefRecipesCubit.get(context).initRecipesCubit(
      category: widget.recipeModel.category!,
      features: widget.recipeModel.features!,
      name: widget.recipeModel.recipeName!,
      desc: widget.recipeModel.recipeDescription!,
      steps: widget.recipeModel.recipeSteps!,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChefRecipesCubit, ChefRecipesState>(
      listener: (context, state) {
        if (state is EditRecipeSuccess) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = ChefRecipesCubit.get(context);
        return Form(
          key: cubit.editRecipeFormKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Here you can edit',
                        style: AppTextStyles.bold16.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.center,
                          ' ${widget.recipeModel.recipeName}',
                          style: AppTextStyles.bold16.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        height: 100,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.recipeModel.recipePhoto ?? '',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          'Click Here to edit your recipe Photo',
                          style: AppTextStyles.bold16.copyWith(
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text('Name',
                      style: AppTextStyles.bold16
                          .copyWith(color: AppColors.secondaryColor)),
                  CustomTextFormField(
                    hintText: widget.recipeModel.recipeName ?? '',
                    controller: cubit.nameController,
                  ),
                  const SizedBox(height: 20),
                  Text('description',
                      style: AppTextStyles.bold16
                          .copyWith(color: AppColors.secondaryColor)),
                  CustomTextFormField(
                    hintText: widget.recipeModel.recipeDescription ?? '',
                    controller: cubit.descriptionController,
                  ),
                  Text('Features',
                      style: AppTextStyles.bold16
                          .copyWith(color: AppColors.secondaryColor)),
                  CustomTextFormField(
                    controller: cubit.featuresController,
                  ),
                  Text('Category',
                      style: AppTextStyles.bold16
                          .copyWith(color: AppColors.secondaryColor)),
                  DropDownSelectCategory(),
                  const SizedBox(height: 20),
                  Text('Steps',
                      style: AppTextStyles.bold16
                          .copyWith(color: AppColors.secondaryColor)),
                  const EditRecipeStepsListView(),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                            text: 'Add Another Step',
                            onTap: () {
                              cubit.addRecipesInput();
                            }),
                      ),
                      if ((cubit.stepsTextControllers?.length ?? 0) > 1)
                        const SizedBox(width: 24),
                      if ((cubit.stepsTextControllers?.length ?? 0) > 1)
                        Expanded(
                          child: CustomButton(
                              text: 'Remove Last Step',
                              onTap: () {
                                cubit.removeRecipesInput();
                              }),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                      text: 'Edit',
                      onTap: () {
                        if (cubit.editRecipeFormKey.currentState!.validate()) {
                          cubit.editRecipe(
                            recipeId: widget.recipeModel.recipeId!,
                          );
                        }
                      }),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  buildOutlineInputBorder() {
    return InputBorder.none;
  }
}
