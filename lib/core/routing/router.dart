import 'package:academe_mobile_new/core/logic/app_cubit.dart';
import 'package:academe_mobile_new/core/routing/app_routes.dart';
import 'package:academe_mobile_new/core/widgets/about.dart';
import 'package:academe_mobile_new/features/attendance/attendance_screen.dart';
import 'package:academe_mobile_new/features/attendance/model/student_model.dart';
import 'package:academe_mobile_new/features/attendance/widgets/cahed_attendance.dart';
import 'package:academe_mobile_new/features/attendance/widgets/search.dart';
import 'package:academe_mobile_new/features/attendance/widgets/student_attendance.dart';
import 'package:academe_mobile_new/features/attendance/widgets/student_info.dart';
import 'package:academe_mobile_new/features/home/data/model/subject_card_model.dart';
import 'package:academe_mobile_new/features/home/home_screen.dart';
import 'package:academe_mobile_new/features/login/logic/login_cubit.dart';
import 'package:academe_mobile_new/features/login/login.dart';
import 'package:academe_mobile_new/features/onBoard/onboard_screen.dart';
import 'package:academe_mobile_new/features/profile/profile_screen.dart';
import 'package:academe_mobile_new/features/profile/widgets/edit_name_id.dart';
import 'package:academe_mobile_new/features/qr/qr_screen.dart';
import 'package:academe_mobile_new/features/qr_scanner/qr_scanner.dart';
import 'package:academe_mobile_new/features/register/logic/register_cubit.dart';
import 'package:academe_mobile_new/features/register/register.dart';
import 'package:academe_mobile_new/features/scaninig_settings/scanninig_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route<dynamic>? generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;
    switch (settings.name) {
      case AppRoutes.onBoard:
        return MaterialPageRoute(builder: (_) => const OnBoard());
      case AppRoutes.login:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LoginCubit(),
                  child: Login(),
                ));
      case AppRoutes.home:
        return MaterialPageRoute(
            builder: (_) => BlocConsumer<AppCubit, AppState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return const Home();
                  },
                ));
      case AppRoutes.register:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => RegisterCubit(),
                  child: Register(),
                ));

      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (_) => Profile(
            publicProfile: false,
          ),
        );

      case AppRoutes.attendance:
        SubjectCardModel args = arguments as SubjectCardModel;

        return MaterialPageRoute(
            builder: (_) => AttendanceScreen(
                  model: args,
                ));

      case AppRoutes.qr:
        return MaterialPageRoute(builder: (_) => const QrScreen());

      case AppRoutes.qrScanner:
        final arg = arguments as Map<String, dynamic>;

        return MaterialPageRoute(
            builder: (_) => QRScanner(
                  model: arg['model'],
                  isOnline: arg['isOnline'],
                ));

      case AppRoutes.studentInfo:
        StudentModel data = arguments as StudentModel;
        return MaterialPageRoute(
            builder: (_) => StudentInfo(
                  data: data,
                ));

      // case AppRoutes.settings:
      //   // Map<String, dynamic> userData = arguments as Map<String, dynamic>;
      //   return MaterialPageRoute(builder: (_) => Settings());

      // case AppRoutes.lecturerLogin:
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider(
      //             create: (context) => LecturerCubit(),
      //             child: const LecturerLogin(),
      //           ));

      case AppRoutes.search:
        SubjectCardModel data = arguments as SubjectCardModel;
        return MaterialPageRoute(
            builder: (_) => Search(
                  model: data,
                ));

      case AppRoutes.scanningSettings:
        SubjectCardModel data = arguments as SubjectCardModel;
        return MaterialPageRoute(
            builder: (_) => ScanninigSettings(
                  model: data,
                ));

      case AppRoutes.cashedAttendance:
        SubjectCardModel data = arguments as SubjectCardModel;
        return MaterialPageRoute(
            builder: (_) => CahedAttendance(
                  model: data,
                ));

      // case AppRoutes.subjectSettings:
      //   final arg = arguments as Map<String, dynamic>;
      //   final SubjectCardModel data = arg['model'] as SubjectCardModel;
      //   final int index = arg['index'] as int;
      //   return MaterialPageRoute(
      //       builder: (_) => SubjectSettings(
      //             model: data,
      //             index: index,
      //           ));

      case AppRoutes.studentAttendance:
        return MaterialPageRoute(builder: (_) => const StudentAttendance());

      case AppRoutes.about:
        return MaterialPageRoute(builder: (_) => const About());

      case AppRoutes.editNameId:
        return MaterialPageRoute(builder: (_) => const EditNameId());

      default:
        return null;
    }
  }
}
