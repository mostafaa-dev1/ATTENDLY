import 'dart:async';

import 'package:academe_mobile_new/core/logic/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_windowmanager_plus/flutter_windowmanager_plus.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  late Timer timer;
  @override
  void initState() {
    super.initState();
    _disableScreenshots();
    reCreateQR();
  }

  Future<void> _disableScreenshots() async {
    await FlutterWindowManagerPlus.addFlags(
        FlutterWindowManagerPlus.FLAG_SECURE);
  }

  @override
  void dispose() {
    _enableScreenshots();
    timer.cancel();
    super.dispose();
  }

  Future<void> _enableScreenshots() async {
    await FlutterWindowManagerPlus.clearFlags(
        FlutterWindowManagerPlus.FLAG_SECURE);
  }

  void reCreateQR() {
    var cubit = context.read<AppCubit>();
    timer = Timer.periodic(const Duration(minutes: 1), (t) {
      context.read<AppCubit>().createCode(
          cubit.student!.name, cubit.student!.id, cubit.student!.gender);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'QR Code',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   height: height / 2.5.h,
              //   width: width / 1.5.w,
              //   padding: const EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(50),
              //       color: Theme.of(context).colorScheme.primary,
              //       boxShadow: [
              //         BoxShadow(
              //             color: Theme.of(context).colorScheme.shadow,
              //             blurRadius: 7,
              //             spreadRadius: 2,
              //             offset: const Offset(0, 3))
              //       ]),
              //   child: Center(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         CustomPaint(
              //           painter: QrPainter(
              //               data: context.read<AppCubit>().code,
              //               options: QrOptions(
              //                   shapes: const QrShapes(
              //                     darkPixel: QrPixelShapeRoundCorners(
              //                       cornerFraction: .5,
              //                     ),
              //                     frame: QrFrameShapeRoundCorners(
              //                         cornerFraction: .25),
              //                     ball: QrBallShapeRoundCorners(
              //                         cornerFraction: .25),
              //                   ),
              //                   colors: QrColors(
              //                     background: QrColor.solid(
              //                       Theme.of(context).colorScheme.primary,
              //                     ),
              //                     ball: QrColor.solid(
              //                       Theme.of(context).canvasColor,
              //                     ),
              //                     frame: QrColor.solid(
              //                       Theme.of(context).canvasColor,
              //                     ),
              //                     dark: QrColor.solid(
              //                       Theme.of(context).canvasColor,
              //                     ),
              //                   ))),
              //           size: Size(width / 1.5.w, height / 3.2.h),
              //         ),
              //         verticalSpace(10),
              //         Text(
              //           context.read<AppCubit>().student!.id,
              //           style: Theme.of(context).textTheme.headlineMedium,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
