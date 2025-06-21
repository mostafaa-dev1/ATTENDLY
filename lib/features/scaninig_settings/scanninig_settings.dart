import 'dart:async';

import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/logic/app_cubit.dart';
import 'package:academe_mobile_new/core/routing/app_routes.dart';
import 'package:academe_mobile_new/core/widgets/custom_button.dart';
import 'package:academe_mobile_new/features/home/data/model/subject_card_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanninigSettings extends StatefulWidget {
  const ScanninigSettings({super.key, required this.model});
  final SubjectCardModel model;

  @override
  State<ScanninigSettings> createState() => _ScanninigSettingsState();
}

class _ScanninigSettingsState extends State<ScanninigSettings> {
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
    // TODO: implement dispose
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'Scanning Settings',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width / 1.1,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.shadow,
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // if (await context
                            //     .read<AppCubit>()
                            //     .isSessionNotFinished(widget.model)) {
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Start Session',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ),
                              verticalSpace(5),
                              Text(
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  'If You start the session, session date and status will stored, so start session when you ready.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              verticalSpace(50),
                              Align(
                                alignment: Alignment.center,
                                child: CustomButton(
                                    buttonName: 'Start',
                                    onPressed: () async {
                                      // if (!connect!) {
                                      //   scaffoldMessinger(
                                      //     context: context,
                                      //     message: 'You are offline',
                                      //     icon: IconBroken.Info_Circle,
                                      //     isError: true,
                                      //   );
                                      // } else if (!context
                                      //     .read<AppCubit>()
                                      //     .isNowLecturer(card: widget.model)) {
                                      //   showAlert(
                                      //       context,
                                      //       'Session can\'t start',
                                      //       'Lecturer isn\'t active, so you can\'t start the session',
                                      //       () {
                                      //     context.pop();
                                      //   }, () {
                                      //     context.pop();
                                      //   }, 'OK', 'Cancel',
                                      //       IconBroken.Info_Circle, false, '');
                                      // } else {
                                      //   showAlert(
                                      //       context,
                                      //       'Are you ready to start the session?',
                                      //       '', () {
                                      //     context
                                      //         .read<AppCubit>()
                                      //         .addStartDate(widget.model);
                                      //     context.pushNamed(AppRoutes.qrScanner,
                                      //         arguments: {
                                      //           'model': widget.model,
                                      //           'isOnline': connect
                                      //         });
                                      //   }, () {
                                      //     context.pop();
                                      //   },
                                      //       'Yes',
                                      //       'Cancel',
                                      //       IconBroken.Info_Circle,
                                      //       false,
                                      //       null);
                                      // }
                                      context
                                          .read<AppCubit>()
                                          .addStartDate(widget.model);
                                      context.pushNamed(AppRoutes.qrScanner,
                                          arguments: {
                                            'model': widget.model,
                                            'isOnline': connect
                                          });
                                      // context.pushNamed(AppRoutes.qrScanner,
                                      //     arguments: {
                                      //       'model': widget.model,
                                      //       'isOnline': connect
                                      //     });
                                      // showAlert(
                                      //     context,
                                      //     'Are you ready to start the session?',
                                      //     '', () {
                                      //   if (!connect!) {
                                      //     context
                                      //         .read<AppCubit>()
                                      //         .setAttendanceOfflineInfo(true);
                                      //     context.pushNamed(AppRoutes.qrScanner,
                                      //         arguments: {
                                      //           'model': widget.model,
                                      //           'isOnline': connect
                                      //         });
                                      //   } else {
                                      //     context
                                      //         .read<AppCubit>()
                                      //         .addStartDate(widget.model);
                                      //     context.pushNamed(AppRoutes.qrScanner,
                                      //         arguments: {
                                      //           'model': widget.model,
                                      //           'isOnline': connect
                                      //         });
                                      //   }
                                      // }, () {
                                      //   context.pop();
                                      // }, 'Yes', 'Cancel',
                                      //     IconBroken.Info_Circle, false, null);
                                    },
                                    width: 100,
                                    paddingVirtical: 5,
                                    paddingHorizental: 10),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
