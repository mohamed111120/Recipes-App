import 'package:flutter/material.dart';

class CustomAddRecipesMinutesTextFormField extends StatelessWidget {
  const CustomAddRecipesMinutesTextFormField({
    super.key,
    required this.controller, this.hintText,
  });

  final TextEditingController? controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Numbers';
        } else {
          return null;
        }
      },
      maxLength: 2,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        border: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
      ),
    );
  }

  buildOutlineInputBorder() {
    return InputBorder.none;
  }
}
