import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipes/features/splash/view/widgets/splash_food_row.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../auth/chef_auth/view/chef_login_view.dart';
import '../../../auth/user_auth/view/user_login_view.dart';
import '../../../user_home_layout/user_home_layout_view.dart';
import 'create_new_account_button.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with TickerProviderStateMixin {
  late AnimationController firstRowAnimationController;
  late AnimationController secondRowAnimationController;
  late Animation<double> firstRowAnimation;
  late Animation<double> secondRowAnimation;
  double rowTowScale = 1.5;

  @override
  void initState() {
    firstRowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    secondRowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    firstRowAnimation =
        Tween<double>(begin: 30, end: 0).animate(firstRowAnimationController);
    secondRowAnimation =
        Tween<double>(begin: 30, end: 0).animate(secondRowAnimationController);

    super.initState();
  }
  @override
  void dispose() {
    firstRowAnimationController.dispose();
    secondRowAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    firstRowAnimationController.forward();
    secondRowAnimationController.forward()..then((value) {
      setState(() {
        rowTowScale = 1;
      });
    },);
 
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xff70B9BE),
      ),
      child: Stack(
        children: [
          SvgPicture.asset('assets/splash_images/background_line.svg'),
          Column(
            children: [
              const SizedBox(height: 40),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Later',
                    style: AppTextStyles.bold18,
                  ),
                ],
              ),
              const SizedBox(height: 80),
              AnimatedBuilder(
                animation: firstRowAnimationController,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()
                      ..rotateZ(firstRowAnimation.value * 3.14 / 180),
                    child: SplashFoodRow(
                      firstImage: AppImages.splashFood1,
                      secondImage: AppImages.splashFood2,
                    ),
                  );
                },
              ),
              const SizedBox(height: 25),
              AnimatedScale(
                scale: rowTowScale,

                duration: const Duration(seconds:2),
                curve: Curves.fastOutSlowIn,
                child: const SplashFoodRow(
                  firstImage: AppImages.splashFood3,
                  secondImage: AppImages.splashFood4,
                ),
              ),
              const SizedBox(height: 25),
              AnimatedBuilder(
                animation: secondRowAnimationController,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()
                      ..rotateZ(secondRowAnimation.value * 3.14 / 180),
                    child: SplashFoodRow(
                      firstImage: AppImages.splashFood5,
                      secondImage: AppImages.splashFood6,
                    ),
                  );
                },
              ),
              const SizedBox(height: 60),
              const Text(
                'Help your path to health goals with happiness',
                textAlign: TextAlign.center,
                style: AppTextStyles.splashTextStyle,
              ),
              const SizedBox(height: 24),
              CustomButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserLoginView(),
                    ),
                  );
                },
                text: 'Login as User',
              ),
              const SizedBox(height: 12),
              CustomButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChefLoginView(),
                    ),
                  );
                },
                text: 'Login as Chef',
              ),
              const SizedBox(height: 16),
              CreateNewAccountButton(),
            ],
          ),
        ],
      ),
    );
  }
}
