import 'package:flutter/material.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/helper_functions/build_auth_show_dialog_function.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../auth/chef_auth/view/chef_sign_up_view.dart';
import '../../../auth/user_auth/view/user_sign_up_view.dart';

class CreateNewAccountButton extends StatelessWidget {
  const CreateNewAccountButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        buildAuthShowDialog(context);
      },
      child: const Text(
        'Create New Account',
        style: AppTextStyles.bold16,
      ),
    );
  }
}
