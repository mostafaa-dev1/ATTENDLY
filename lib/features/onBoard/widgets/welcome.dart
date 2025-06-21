import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/themes/text_styles.dart';
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
        TextSpan(text: 'ACADEME', style: AppTextStyles.style27Bc)
      ])),
      verticalSpace(10.h),
      SizedBox(
        width: MediaQuery.sizeOf(context).width > 500
            ? MediaQuery.sizeOf(context).width / 2
            : MediaQuery.sizeOf(context).width / 1.5,
        child: Text(
            textAlign: TextAlign.center,
            'Streamline your education management with our app: track attendance, create quizzes,and monitor student progress effortlessly.',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
    ]);
  }
}
