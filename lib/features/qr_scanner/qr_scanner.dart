import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/logic/app_cubit.dart';
import 'package:academe_mobile_new/core/routing/app_routes.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:academe_mobile_new/core/widgets/alert.dart';
import 'package:academe_mobile_new/core/widgets/custom_button.dart';
import 'package:academe_mobile_new/features/home/data/model/subject_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key, required this.model, required this.isOnline});
  final SubjectCardModel model;
  final bool isOnline;

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey key = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? qrController;
  int progress = 0;
  void onScanned(QRViewController controller) {
    qrController = controller;

    controller.scannedDataStream.listen((event) {
      try {
        context.read<AppCubit>().scanner(event.code!, widget.model);
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    super.dispose();
    //qrController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var wl500 = width > 500;
    var height = MediaQuery.of(context).size.height;
    var cubit = context.read<AppCubit>();

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        var result = context.read<AppCubit>().result;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            leadingWidth: 30,
            title: Text(widget.model.name,
                style: Theme.of(context).textTheme.headlineLarge),
          ),
          body: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              showAlert(context, 'Would you like to finish session',
                  'This will finish today registration', () {
                context.read<AppCubit>().setAttendanceOnlineInfo(
                    widget.model.level, widget.model.passcode, false);

                context.pushNamedAndRemoveUntil(AppRoutes.home);
              }, () {
                context.pop();
              }, 'Yes', 'Cancel', IconBroken.Info_Circle, false, null);
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.shadow,
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          )
                        ]),
                    height: height / 2.1,
                    width: width / 1.1,
                    child: QRView(
                      key: key,
                      onQRViewCreated: onScanned,
                      overlay: QrScannerOverlayShape(
                        borderColor: Colors.white,
                        borderRadius: 20,
                        borderLength: 30,
                        borderWidth: 10,
                        cutOutHeight: height / 3,
                        cutOutWidth: width / 1.5,
                      ),
                    ),
                  )),
                  Container(
                    width: width / 1.1,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.shadow,
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 5),
                          )
                        ]),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            result == null ? 'Scanning..' : result['name'],
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          verticalSpace(10),
                          Text(
                            result == null ? '' : result['id'],
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          verticalSpace(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              result == null
                                  ? const SizedBox()
                                  : Text(
                                      'QR date : ${result == null ? '' : result['date']}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                              result == null
                                  ? const SizedBox()
                                  : Text(
                                      'My date : ${cubit.myDate}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                              result == null
                                  ? const SizedBox()
                                  : Text(
                                      'Difference : ${cubit.defference}s',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                            ],
                          ),
                          verticalSpace(20),
                          Container(
                            width: width / 1.4,
                            height: 1,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          verticalSpace(10),
                          Center(
                              child: LinearPercentIndicator(
                            lineHeight: wl500 ? 20 : 15,
                            barRadius: const Radius.circular(20),
                            animateFromLastPercent: true,
                            animation: true,
                            animationDuration: 1200,
                            percent: cubit.successRegistration /
                                (cubit.progress == 0 ? 1 : cubit.progress),
                            center: Text(
                              '${((cubit.successRegistration / (cubit.progress == 0 ? 1 : cubit.progress)) * 100).toStringAsFixed(0)}%',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            progressColor: AppColors.mainColor,
                          )),
                          verticalSpace(10),
                          Text(
                            '${cubit.successRegistration}/${cubit.progress}',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          verticalSpace(10),
                          Text(
                            state is SetStudentErrorState
                                ? state.error
                                : state is SetStudentErrorState
                                    ? state.error
                                    : 'In Progress..',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: state is SetStudentErrorState ||
                                          state is SetStudentErrorState
                                      ? Colors.red
                                      : AppColors.mainColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  verticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        withBorderSide: true,
                        buttonColor: AppColors.mainColor,
                        buttonName: 'QR Code',
                        onPressed: () {
                          context.read<AppCubit>().createCode(
                                cubit.student!.name,
                                cubit.student!.id,
                                cubit.student!.gender,
                              );
                          //showQR(context);
                          // qrController!.pauseCamera();
                        },
                        width: width / 2.5,
                        paddingVirtical: 5,
                        paddingHorizental: 10,
                      ),
                      horizontalSpace(10),
                      CustomButton(
                          buttonName: 'End Session',
                          onPressed: () {
                            showAlert(
                                context,
                                'Would you like to finish session',
                                'This will finish today registration', () {
                              context.read<AppCubit>().setAttendanceOnlineInfo(
                                  widget.model.level,
                                  widget.model.passcode,
                                  false);

                              context.pushNamedAndRemoveUntil(AppRoutes.home);
                            }, () {
                              context.pop();
                            }, 'Yes', 'Cancel', IconBroken.Info_Circle, false,
                                null);
                          },
                          width: width / 2.5,
                          paddingVirtical: 5,
                          paddingHorizental: 10),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // void showQR(BuildContext context) {
  //   Alert(
  //     context: context,
  //     alertAnimation: (context, animation, secondaryAnimation, child) {
  //       return FadeTransition(
  //         opacity: animation,
  //         child: child,
  //       );
  //     },
  //     style: AlertStyle(
  //       isOverlayTapDismiss: false,
  //       backgroundColor: Theme.of(context).cardColor,
  //       isCloseButton: false,
  //     ),
  //     buttons: [
  //       DialogButton(
  //         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
  //         splashColor: Colors.transparent,
  //         color: Theme.of(context).cardColor,
  //         border: Border.all(
  //           color: AppColors.mainColor,
  //         ),
  //         onPressed: () {
  //           context.pop();
  //           // qrController!.resumeCamera();
  //         },
  //         child: Text(
  //           'Close',
  //           style: Theme.of(context)
  //               .textTheme
  //               .headlineMedium!
  //               .copyWith(color: AppColors.mainColor),
  //         ),
  //       ),
  //     ],
  //     content: Center(
  //       child: CustomPaint(
  //         willChange: true,
  //         painter: QrPainter(
  //             data: context.read<AppCubit>().code,
  //             options: QrOptions(
  //                 shapes: const QrShapes(
  //                   darkPixel: QrPixelShapeRoundCorners(
  //                     cornerFraction: .5,
  //                   ),
  //                   frame: QrFrameShapeRoundCorners(cornerFraction: .25),
  //                   ball: QrBallShapeRoundCorners(cornerFraction: .25),
  //                 ),
  //                 colors: QrColors(
  //                   background: QrColor.solid(
  //                     Theme.of(context).colorScheme.primary,
  //                   ),
  //                   ball: QrColor.solid(
  //                     Theme.of(context).canvasColor,
  //                   ),
  //                   frame: QrColor.solid(
  //                     Theme.of(context).canvasColor,
  //                   ),
  //                   dark: QrColor.solid(
  //                     Theme.of(context).canvasColor,
  //                   ),
  //                 ))),
  //         size: Size(MediaQuery.of(context).size.width / 1.5.w,
  //             MediaQuery.of(context).size.height / 3.2.h),
  //       ),
  //     ),
  //     // verticalSpace(10),
  //     // Text(
  //     //   context.read<AppCubit>().student!.id,
  //     //   style: Theme.of(context).textTheme.headlineMedium,
  //     // ),
  //   ).show();
  //}
}
