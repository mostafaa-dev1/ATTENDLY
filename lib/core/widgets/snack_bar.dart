import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showSnackBar(
    {required BuildContext context,
    required String message,
    required AnimatedSnackBarType type}) {
  AnimatedSnackBar(
      duration: const Duration(seconds: 5),
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      desktopSnackBarPosition: DesktopSnackBarPosition.bottomCenter,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          height: 50,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: type == AnimatedSnackBarType.error
                ? Colors.red
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                type == AnimatedSnackBarType.error
                    ? Icons.error
                    : Icons.check_sharp,
                color: type == AnimatedSnackBarType.error
                    ? Colors.white
                    : AppColors.mainColor,
              ),
              horizontalSpace(10),
              Text(
                message,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: type == AnimatedSnackBarType.error
                        ? Colors.white
                        : AppColors.mainColor),
              ),
            ],
          ),
        );
      }).show(context);
}
