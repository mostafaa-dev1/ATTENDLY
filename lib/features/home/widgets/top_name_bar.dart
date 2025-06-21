import 'dart:async';

import 'package:academe_mobile_new/core/Constants/constants.dart';
import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/helpers/shared_functions.dart';
import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/logic/app_cubit.dart';
import 'package:academe_mobile_new/core/models/student_model.dart';
import 'package:academe_mobile_new/core/routing/app_routes.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:academe_mobile_new/core/widgets/alert.dart';
import 'package:academe_mobile_new/core/widgets/profile_image.dart';
import 'package:academe_mobile_new/core/widgets/sacffold_messinger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';

class TopNameBar extends StatefulWidget {
  const TopNameBar({super.key});

  @override
  State<TopNameBar> createState() => _TopNameBarState();
}

class _TopNameBarState extends State<TopNameBar> {
  @override
  void initState() {
    super.initState();
    checkStreamConnectivity();
  }

  bool? connect = true;
  StreamSubscription<List<ConnectivityResult>>? subscription;

  void checkStreamConnectivity() async {
    final List<ConnectivityResult> result =
        await (Connectivity().checkConnectivity());
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        setState(() {
          connect = true;
        });
      } else {
        setState(() {
          connect = false;
        });
      }
    });
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)) {
      setState(() {
        connect = true;
      });
    } else {
      setState(() {
        connect = false;
      });
    }
  }

  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }

  String splitname = '';
  String name = Constants.name;
  String id = Constants.id;
  String gender = Constants.gender;
  String image = Constants.image;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is NoInternetConnection) {
          scaffoldMessinger(
              context: context,
              message: state.error,
              icon: Icons.wifi_off,
              isError: true);
        }
      },
      builder: (context, state) {
        var cubit = context.read<AppCubit>();
        splitname = SharedFunctions.split(cubit.student!.name);

        return Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (connect!) {
                  if (cubit.student!.isBlocked) {
                    showAlert(context, 'Blocked',
                        'You are blocked from using the app', () {
                      context.pop();
                    }, () {
                      context.pop();
                    }, 'OK', 'Cancel', IconBroken.Info_Circle, false, '');
                  } else {
                    context.pushNamed(AppRoutes.profile, arguments: {
                      'id': cubit.student!.id,
                      'publicProfile': false
                    });

                    cubit.getProfileData(cubit.student!.id,
                        cubit.student!.department == 'Lecturer');
                  }
                } else {
                  scaffoldMessinger(
                      context: context,
                      message: 'No Internet',
                      icon: Icons.wifi_off,
                      isError: false);
                }
              },
              child: AnimatedContainer(
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                width: connect! ? MediaQuery.of(context).size.width : 150.w,
                duration: const Duration(milliseconds: 400),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 7,
                        spreadRadius: 2,
                        color: Theme.of(context).colorScheme.shadow,
                        offset: const Offset(0, 3)),
                  ],
                ),
                child: !connect!
                    ? networkStatus(context)
                    : studentData(cubit.student!, context),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget studentData(HomeStudentModel student, BuildContext context) {
    String splitname = SharedFunctions.split(student.name);
    return Row(
      children: [
        ProfileImage(
            imageUrl: student.image!, height: 40, width: 40, gender: gender),
        horizontalSpace(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                '${student.department == 'Lecturer' ? 'Prof.' : ''}$splitname',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                  student.department == 'Lecturer'
                      ? 'Professor'
                      : student.isAdmin
                          ? '$id (Admin)'
                          : id,
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
        const Icon(
          IconBroken.Arrow___Right_2,
        )
      ],
    );
  }

  Widget networkStatus(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CupertinoActivityIndicator(
          color: AppColors.mainColor,
        ),
        horizontalSpace(10),
        Text(
          'Connecting...',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
