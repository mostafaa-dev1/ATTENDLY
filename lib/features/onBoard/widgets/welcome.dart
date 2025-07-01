import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text.rich(TextSpan(children: [
        TextSpan(
            text: 'Welcome to ', style: Theme.of(context).textTheme.titleLarge),
        TextSpan(
            text: 'ACADEME',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: AppColors.mainColor)),
      ])),
      verticalSpace(10.h),
      Expanded(
        child: Text(
            textAlign: TextAlign.center,
            'Streamline your education management with our app: track attendance, create quizzes,and monitor student progress effortlessly.',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
    ]);
  }
}
