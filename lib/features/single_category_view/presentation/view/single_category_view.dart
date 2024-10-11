import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/core/services/database_service.dart';
import 'package:food_recipes/core/services/register_service.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../manager/single_category_cubit.dart';
import '../widgets/singel_category_view_body.dart';

class SingleCategoryView extends StatelessWidget {
  const SingleCategoryView({super.key, required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SingleCategoryCubit(databaseService: getIt.get<DatabaseService>())
            ..getRecipesByCategory(category: categoryName),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            categoryName,
            style: AppTextStyles.bold18.copyWith(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: const SingleCategoryViewBody(),
      ),
    );
  }
}
