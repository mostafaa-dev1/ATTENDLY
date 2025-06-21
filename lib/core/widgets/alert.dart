import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:academe_mobile_new/core/widgets/app_text_form.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void showAlert(
    BuildContext context,
    String? title,
    String message,
    VoidCallback? onConfirm,
    VoidCallback onCancel,
    String confirmbuttonText,
    String cancelButtonText,
    IconData? icon,
    bool? isLottie,
    String? image) {
  Alert(
      context: context,
      alertAnimation: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      style: AlertStyle(
        isOverlayTapDismiss: false,
        backgroundColor: Theme.of(context).cardColor,
        isCloseButton: false,
      ),
      buttons: [
        DialogButton(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
          splashColor: Colors.transparent,
          color: Theme.of(context).cardColor,
          border: Border.all(
            color: AppColors.mainColor,
          ),
          onPressed: onCancel,
          child: Text(cancelButtonText,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: AppColors.mainColor)),
        ),
        DialogButton(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
            onPressed: onConfirm,
            color: AppColors.mainColor,
            border: Border.all(
              color: AppColors.mainColor,
            ),
            child: Text(confirmbuttonText,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.white))),
      ],
      content: Column(
        children: [
          icon == null
              ? Image(image: AssetImage(image!))
              : Icon(
                  icon,
                  size: 40,
                ),
          verticalSpace(10),
          title == null
              ? const SizedBox()
              : Text(
                  textAlign: TextAlign.center,
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
          verticalSpace(5),
          Text(
            textAlign: TextAlign.center,
            message,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      )).show();
}

void showTextFormAlert(
  BuildContext context,
  String message,
  VoidCallback? onConfirm,
  VoidCallback onCancel,
  String confirmbuttonText,
  String cancelButtonText,
  TextEditingController controller,
) {
  Alert(
      context: context,
      style: const AlertStyle(isCloseButton: false),
      buttons: [
        DialogButton(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
          splashColor: Colors.transparent,
          color: Theme.of(context).cardColor,
          border: Border.all(
            color: AppColors.mainColor,
          ),
          onPressed: onCancel,
          child: Text(
              textAlign: TextAlign.center,
              cancelButtonText,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: AppColors.mainColor)),
        ),
        DialogButton(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
            onPressed: onConfirm,
            color: AppColors.mainColor,
            border: Border.all(
              color: AppColors.mainColor,
            ),
            child: Text(
                textAlign: TextAlign.center,
                confirmbuttonText,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.white))),
      ],
      content: Column(
        children: [
          verticalSpace(5),
          Text(
            message,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          verticalSpace(15),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('New ID',
                  style: Theme.of(context).textTheme.headlineMedium)),
          CustomTextFrom(
            withhint: false,
            hintText: 'Image Url',
            controller: controller,
            keyboardType: TextInputType.text,
          )
        ],
      )).show();
}
