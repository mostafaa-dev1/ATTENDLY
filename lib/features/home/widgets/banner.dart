import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/logic/app_cubit.dart';
import 'package:academe_mobile_new/core/routing/app_routes.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:academe_mobile_new/core/widgets/alert.dart';
import 'package:academe_mobile_new/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icon_broken/icon_broken.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key, required this.version});
  final String version;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AppCubit>();

    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            colors: [
              AppColors.mainColor,
              Color.fromARGB(255, 0, 70, 200),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Simplify Your Attendance ',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Colors.white,
                      ),
                ),
                verticalSpace(10),
                Text(
                  'Simplify Your Attendance by scan your QR Code',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                      ),
                ),
                verticalSpace(20),
                CustomButton(
                  buttonColor: AppColors.mainColor,
                  backgroundColor: Colors.white,
                  buttonName: 'My QR Code',
                  fontSize: 12,
                  onPressed: () {
                    if (cubit.student!.isBlocked || version != cubit.version) {
                      showAlert(
                        context,
                        version != cubit.version
                            ? 'Update Available'
                            : 'Blocked',
                        version != cubit.version
                            ? 'A new version of Academe is available. \nPlease update to continue using the app'
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
                  width: 100,
                  paddingVirtical: 10,
                  paddingHorizental: 10,
                )
              ],
            ),
          ),
          verticalSpace(10),
          SvgPicture.asset(
            'assets/images/banner1.svg',
            width: 100,
            height: 150,
          ),
        ],
      ),
    );
  }
}
