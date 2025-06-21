import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:flutter/material.dart';

void scaffoldMessinger({
  required BuildContext context,
  required String message,
  required IconData icon,
  required bool isError,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            icon,
            color: isError ? Colors.white : AppColors.mainColor,
          ),
          horizontalSpace(10),
          SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            child: Text(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              message,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: isError ? Colors.white : AppColors.mainColor,
                  ),
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 6),
      backgroundColor: isError ? Colors.red : Theme.of(context).cardColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
    ),
  );
}
