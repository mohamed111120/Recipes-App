import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipes/features/auth/chef_auth/manager/chef_sign_up_cubit/chef_sign_up_cubit.dart';
import 'package:food_recipes/main_models/chef_model.dart';

import '../../../core/constants/app_colors.dart';

class AddPhotoWidget extends StatelessWidget {
  const AddPhotoWidget({
    super.key,
    required this.onTap,
    required this.file,
  });

  final void Function()? onTap;
  final File? file;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: file == null ? null : FileImage(file!),
      backgroundColor: Colors.white,
      child: Align(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onTap:onTap,
          child: CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.primaryColor,
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
