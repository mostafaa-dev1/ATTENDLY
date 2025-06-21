import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HaveAccount extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String type;
  const HaveAccount(
      {super.key, required this.onTap, required this.text, required this.type});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Text.rich(TextSpan(children: [
          TextSpan(
            text: text,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          TextSpan(
              text: type,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: AppColors.mainColor),
              recognizer: TapGestureRecognizer()..onTap = onTap)
        ])));
  }
}
