import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_colors.dart';

class BottomNavBarChefIcon extends StatelessWidget {
  const BottomNavBarChefIcon({
    super.key, this.onTap,
  });
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.secondaryColor,
        ),
        child: Align(
          child: SvgPicture.asset(
            colorFilter:
                ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            height: 33,
            'assets/icons/chef.svg',
          ),
        ),
      ),
    );
  }
}
