import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final double width;
  final double? height;

  final double paddingVirtical;
  final double paddingHorizental;
  final double? fontSize;
  final Color? backgroundColor;
  final Color? buttonColor;
  final double? borderRadius;
  final bool? withBorderSide;
  final bool? isLoading;
  final IconData? icon;
  final double? iconSize;
  final bool? reightIcon;

  const CustomButton(
      {super.key,
      required this.buttonName,
      required this.onPressed,
      required this.width,
      required this.paddingVirtical,
      required this.paddingHorizental,
      this.fontSize,
      this.backgroundColor,
      this.buttonColor,
      this.borderRadius,
      this.withBorderSide,
      this.isLoading,
      this.height,
      this.icon,
      this.iconSize,
      this.reightIcon});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(
                horizontal: paddingHorizental.w, vertical: paddingVirtical.h),
          ),
          minimumSize:
              WidgetStateProperty.all<Size>(Size(width.w, height ?? 40.h)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
                side: BorderSide(
                  color: withBorderSide ?? false
                      ? backgroundColor ?? AppColors.mainColor
                      : Colors.transparent,
                )),
          ),
          backgroundColor: WidgetStateProperty.all(withBorderSide ?? false
              ? Colors.transparent
              : backgroundColor ?? AppColors.mainColor)),
      onPressed: onPressed,
      child: isLoading ?? false
          ? Center(
              child: SizedBox(
                height: 20.h,
                width: 20.w,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            )
          : Text(
              buttonName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: buttonColor ?? Colors.white,
                    fontSize: fontSize ?? 16.sp,
                  ),
            ),
    );
  }
}
