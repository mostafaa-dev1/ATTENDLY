import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/routing/app_routes.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:academe_mobile_new/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class LoginRegisterButtons extends StatelessWidget {
  const LoginRegisterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomButton(
        buttonName: 'Login',
        onPressed: () {
          context.pushNamed(AppRoutes.login);
        },
        width: MediaQuery.sizeOf(context).width / 1.5,
        paddingVirtical: 10,
        paddingHorizental: 20,
        borderRadius: 50,
        withBorderSide: false,
        backgroundColor: AppColors.mainColor,
      ),
      verticalSpace(10),
      CustomButton(
        buttonName: 'Register',
        onPressed: () {
          context.pushNamed(AppRoutes.register);
        },
        width: MediaQuery.sizeOf(context).width / 1.5,
        paddingVirtical: 10,
        paddingHorizental: 20,
        borderRadius: 50,
        withBorderSide: true,
        buttonColor: AppColors.mainColor,
      ),
    ]);
  }
}
