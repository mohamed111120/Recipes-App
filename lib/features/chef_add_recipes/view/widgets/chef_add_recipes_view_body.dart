import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/payment_service.dart';
import 'package:food_recipes/core/utils/custom_toast.dart';
import 'package:food_recipes/core/widgets/custom_button.dart';
import 'package:food_recipes/features/chef_add_recipes/manager/add_recipres_cubit/add_recipes_cubit.dart';
import 'package:food_recipes/features/chef_add_recipes/view/widgets/chef_add_recipes_submit_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import 'chef_add_recipes_add_image_widget.dart';
import 'chef_add_recipes_steps_list_view.dart';

class ChefAddRecipesViewBody extends StatelessWidget {
  const ChefAddRecipesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddRecipesCubit, AddRecipesState>(
      listener: (context, state) {
        if (state is SubmitRecipeSuccess) {
          showToast(
              message: 'Recipe Added Successfully', state: ToastState.success);
          Navigator.pop(context);
        }
        if (state is SubmitRecipeError) {
          showToast(message: 'Something went wrong', state: ToastState.error);
        }
      },
      builder: (context, state) {
        var recipesCubit = AddRecipesCubit.get(context);
        return Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
          child: Form(
            key: recipesCubit.formKey,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: ChefAddRecipesAddImageWidget(
                    onTap: () async {
                      await recipesCubit.getImageFromGallary();
                      if (recipesCubit.recipeImageFile != null) {
                        recipesCubit.uploadRecipeImage(
                          recipesCubit.recipeImageFile!,
                        );
                      }
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      const Text(
                        'Recipe Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      CustomTextFormField(
                        controller: recipesCubit.nameController,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recipe Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      CustomTextFormField(
                        controller: recipesCubit.descriptionController,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recipe Features',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      CustomTextFormField(
                        controller: recipesCubit.featuresController,
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Text(
                    'Steps',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                ChefAddRecipesStepsListView(
                    count: recipesCubit.stepsTextControllers?.length ?? 0),
                SliverToBoxAdapter(
                  child: Column(children: [
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                              text: 'Add Another Step',
                              onTap: () {
                                recipesCubit.addRecipesInput();
                              }),
                        ),
                        if ((recipesCubit.stepsTextControllers?.length ?? 0) >
                            1)
                          const SizedBox(width: 24),
                        if ((recipesCubit.stepsTextControllers?.length ?? 0) >
                            1)
                          Expanded(
                            child: CustomButton(
                                text: 'Remove Last Step',
                                onTap: () {
                                  recipesCubit.removeRecipesInput();
                                }),
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ]),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recipe Total Calories',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      CustomTextFormField(
                        controller: recipesCubit.caloriesController,
                        keyboardType:  TextInputType.number,
                        prefixIcon: Icons.local_fire_department_outlined,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recipe Category',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      DropdownButtonFormField(
                        validator: (value) {
                          if (value == null) {
                            return 'Please Select Category';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: buildOutlineInputBorder(),
                          focusedBorder: buildOutlineInputBorder(),
                          border: buildOutlineInputBorder(),
                        ),
                        value: recipesCubit.recipeCategory,
                        hint:  const Text('Select Recipe Category'),
                        items: [
                          const DropdownMenuItem(
                            value: 'Breakfast',
                            child: Text('Breakfast'),
                          ),
                          const DropdownMenuItem(
                            value: 'Lunch',
                            child: Text('Lunch'),
                          ),
                          const DropdownMenuItem(
                            value: 'Dinner',
                            child: Text('Dinner'),
                          ),
                          const DropdownMenuItem(
                            value: 'Another',
                            child: Text('Another'),
                          ),
                        ],
                        onChanged: (value) {
                          recipesCubit.changeRecipeCategory(value);
                        },
                      ),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 40,
                              width: 150,
                              child: CustomButton(
                                onTap: () {
                                  PaymentService()
                                      .getPaymentKey(
                                    amount: 20,
                                    currency: 'EGP',
                                  )
                                      .then(
                                    (paymentKey) {
                                      PaymentService()
                                          .pay(paymentKey: paymentKey);
                                    },
                                  ).then(
                                    (_) {
                                      recipesCubit.makeRecipeFeatured();
                                    },
                                  );
                                },
                                color: AppColors.secondaryColor.withOpacity(.8),
                                text: 'Featured Recipe',
                              ),
                            ),
                            const SizedBox(width: 12),
                            recipesCubit.isFeatured
                                ? const Icon(
                                    Icons.done_outline_rounded,
                                    color: AppColors.primaryColor,
                                  )
                                : const Expanded(
                                    child: Text(
                                      'you have to pay 20EGP to make this recipe appear in featured section',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      ChefAddRecipesSubmitButton(
                        onTap: () {
                          if (recipesCubit.recipeImageUrl == null) {
                            showToast(
                                message: 'Please Add Recipe Image',
                                state: ToastState.error);
                          }
                          if (recipesCubit.formKey.currentState!.validate() &&
                              recipesCubit.recipeImageUrl != null) {
                            recipesCubit.submitYourRecipe();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.secondaryColor.withOpacity(.8),
          width: 2,
        ));
  }
}
