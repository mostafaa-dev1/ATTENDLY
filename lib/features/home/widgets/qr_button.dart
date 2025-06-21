import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/logic/app_cubit.dart';
import 'package:academe_mobile_new/core/routing/app_routes.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:academe_mobile_new/core/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

class QrButton extends StatelessWidget {
  const QrButton({super.key, required this.version});
  final String version;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AppCubit>();
    return GestureDetector(
      onTap: () {
        if (cubit.student!.isBlocked || version != cubit.version) {
          showAlert(
            context,
            version != cubit.version ? 'Update Available' : 'Blocked',
            version != cubit.version
                ? 'A new version of Academe is available. \nPlease update to continue using the app.'
                : 'You are blocked from using the app',
            () {
              context.pop();
            },
            () {
              context.pop();
            },
            'OK',
            'Cancel',
            IconBroken.Info_Circle,
            false,
            '',
          );
        } else {
          context.pushNamed(
            AppRoutes.qr,
          );
          context.read<AppCubit>().createCode(
                cubit.student!.name,
                cubit.student!.id,
                cubit.student!.gender,
              );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ]),
        child: Row(
          children: [
            const Icon(
              Icons.qr_code,
              color: Colors.white,
            ),
            horizontalSpace(10),
            Text(
              'My QR Code',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
