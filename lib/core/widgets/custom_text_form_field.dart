import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.onTap,
    this.prefixIcon,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.stepNum,
    this.validator,
  });

  final void Function()? onTap;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final int? stepNum;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
      child: TextFormField(
        minLines: 1,
        maxLines: 5,
        controller: controller,
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter text';
              } else {
                return null;
              }
            },
        keyboardType: keyboardType,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hintText,
          border: buildOutlineInputBorder(),
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
          prefixIcon: Icon(
            prefixIcon,
            color: AppColors.secondaryColor.withOpacity(.8),
          ),
        ),
      ),
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
