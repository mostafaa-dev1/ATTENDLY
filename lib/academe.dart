import 'package:academe_mobile_new/core/logic/app_cubit.dart';
import 'package:academe_mobile_new/core/networking/local_database/shared_preferances.dart';
import 'package:academe_mobile_new/core/routing/app_routes.dart';
import 'package:academe_mobile_new/core/routing/router.dart';
import 'package:academe_mobile_new/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AcademeApp extends StatelessWidget {
  AcademeApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  final bool logged = CashHelper.getBool(key: 'logged') ?? false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ScreenUtilInit(
      designSize: Size(width, height),
      minTextAdapt: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => AppCubit(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Academe',
            theme: buildAppTheme(locale: 'ar', isDark: false),
            onGenerateRoute: (settings) {
              return appRouter.generateRoute(settings);
            },
            themeMode: ThemeMode.system,
            initialRoute: logged ? AppRoutes.login : AppRoutes.onBoard,
          ),
        );
      },
    );
  }
}
