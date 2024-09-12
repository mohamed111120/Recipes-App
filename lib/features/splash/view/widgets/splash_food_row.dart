import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashFoodRow extends StatelessWidget {
  const SplashFoodRow(
      {super.key, required this.firstImage, required this.secondImage});

  final String firstImage, secondImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(firstImage),
        const SizedBox(
          width: 80,
        ),
        SvgPicture.asset(secondImage),
      ],
    );
  }
}
