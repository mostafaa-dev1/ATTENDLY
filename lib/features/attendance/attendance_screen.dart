import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/logic/app_cubit.dart';
import 'package:academe_mobile_new/core/routing/app_routes.dart';
import 'package:academe_mobile_new/features/attendance/widgets/attendance_items.dart';
import 'package:academe_mobile_new/features/home/data/model/subject_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({
    super.key,
    required this.model,
  });
  final SubjectCardModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leadingWidth: 30,
        title:
            Text(model.name, style: Theme.of(context).textTheme.headlineLarge),
        actions: [
          IconButton(
              onPressed: () {
                context.pushNamed(AppRoutes.search, arguments: model);
              },
              icon: const Icon(IconBroken.Search)),
          // IconButton(
          //     onPressed: () {
          //       // context.read<AppCubit>().exportToExcel(
          //       //     subjectName: model.name,
          //       //     students: context.read<AppCubit>().studentsModel!);
          //     },
          //     icon: const Icon(IconBroken.Download)),
        ],
      ),
      body: AttendanceItem(
        subjectName: model.name,
      ),
    );
  }
}
