import 'package:flutter/material.dart';
import '../../../core/utils/app_text_styles.dart';
import 'widgets/chef_home_view_body.dart';

class ChefHomeView extends StatelessWidget {
  const ChefHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.wb_sunny_outlined,
                  color: Color(0xff4D8194),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  'Good Morning',
                  style: AppTextStyles.regular14.copyWith(
                    color: const Color(0xff0A2533),
                  ),
                ),
              ],
            ),
            const Icon(Icons.add)
          ],
        ),
      ),
      body: ChefHomeViewBody(),
    );
  }
}
