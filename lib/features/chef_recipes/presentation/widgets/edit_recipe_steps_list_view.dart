import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../manger/chef_recipes_cubit.dart';

class EditRecipeStepsListView extends StatelessWidget {
  const EditRecipeStepsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChefRecipesCubit, ChefRecipesState>(
      builder: (context, state) {
        return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:
                ChefRecipesCubit.get(context).stepsTextControllers!.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: ChefRecipesCubit.get(context)
                          .stepsTextControllers![index],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.secondaryColor.withOpacity(.8),
                    ),
                    width: 65,
                    height: 65,
                    child: Center(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: ChefRecipesCubit.get(context)
                            .minutesTextControllers![index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          border: buildOutlineInputBorder(),
                          enabledBorder: buildOutlineInputBorder(),
                          focusedBorder: buildOutlineInputBorder(),
                          disabledBorder: buildOutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            });
      },
    );
  }

  buildOutlineInputBorder() {
    return InputBorder.none;
  }
}
