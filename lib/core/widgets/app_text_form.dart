// ignore_for_file: unrelated_type_equality_checks

import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:academe_mobile_new/core/themes/text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFrom extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final String? prefixText;
  final bool? withhint;
  final int? maxLines;
  final int? maxLength;
  final String? counterText;
  final bool? enabled;

  const CustomTextFrom({
    super.key,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
    this.obscureText,
    this.validator,
    required this.keyboardType,
    this.prefixText,
    this.withhint,
    this.maxLines,
    this.maxLength,
    this.counterText,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        withhint ?? true
            ? Text(hintText ?? '',
                style: Theme.of(context).textTheme.headlineMedium)
            : const SizedBox(),
        verticalSpace(5),
        SizedBox(
          width: kIsWeb && MediaQuery.of(context).size.width > 500
              ? 500
              : double.infinity,
          child: TextFormField(
            validator: (value) {
              if (value != null) {
                return validator!(value);
              }
              return null;
            },
            enabled: enabled ?? true,
            maxLines: maxLines == 0 ? null : 1,
            maxLength: maxLength,
            controller: controller,
            obscureText: obscureText ?? false,
            style: Theme.of(context).textTheme.headlineMedium,
            keyboardType: keyboardType,
            cursorColor: AppColors.mainColor,
            decoration: InputDecoration(
              counterText: counterText,
              isDense: true,
              enabled: true,
              filled: true,
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).cardColor),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: AppColors.mainColor, width: 2),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.red),
              ),
              errorStyle: TextStyle(color: Colors.red.shade100),
              prefixText: prefixText,
              suffixIcon: suffixIcon,
              hintText: hintText,
              prefixStyle: Theme.of(context).textTheme.headlineMedium,
              hintStyle: AppTextStyles.style13w400g700
                  .copyWith(color: Colors.grey[400]),
            ),
          ),
        ),
      ],
    );
  }
}
