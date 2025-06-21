import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/helpers/images_helpers.dart';
import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/logic/app_cubit.dart';
import 'package:academe_mobile_new/core/routing/app_routes.dart';
import 'package:academe_mobile_new/core/themes/text_styles.dart';
import 'package:academe_mobile_new/core/widgets/nodata.dart';
import 'package:academe_mobile_new/core/widgets/sacffold_messinger.dart';
import 'package:academe_mobile_new/features/attendance/model/student_model.dart';
import 'package:academe_mobile_new/features/home/data/model/subject_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';

class CahedAttendance extends StatelessWidget {
  const CahedAttendance({super.key, required this.model});
  final SubjectCardModel model;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is ExportCachedStudentsSuccessState) {
          scaffoldMessinger(
              context: context,
              message: 'Successfully Exported',
              icon: Icons.check,
              isError: false);
        }
      },
      builder: (context, state) {
        var attendance = context.read<AppCubit>().lastAttendance;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              model.name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    if (attendance == null || attendance.students.isEmpty) {
                      scaffoldMessinger(
                          context: context,
                          message: 'There is no attendances',
                          icon: Icons.error,
                          isError: true);
                      return;
                    }
                    // context.read<AppCubit>().exportToExcel(
                    //     subjectName: model.name, students: attendance);
                  },
                  icon: const Icon(IconBroken.Upload)),
            ],
          ),
          body: attendance!.students.isEmpty
              ? const Nodata(text: 'There is no attendances')
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('The last attendance',
                          style: Theme.of(context).textTheme.headlineMedium),
                    ),
                    verticalSpace(5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                          'Total Students : ${attendance.students.length}',
                          style: Theme.of(context).textTheme.headlineMedium),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return item(context, attendance.students[index]);
                        },
                        itemCount: attendance.students.length,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget item(BuildContext context, StudentModel model) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      child: GestureDetector(
        onTap: () {
          context.pushNamed(AppRoutes.studentInfo, arguments: model);
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.shadow,
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ]),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Image(
                image: AssetImage(ImagesHelpers.genderImage(model.gender)),
                height: 40.h,
              ),
              title: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  model.name!,
                  style: theme.textTheme.headlineMedium),
              subtitle: Text(model.id.toString(),
                  style: AppTextStyles.style13w400g700.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.grey[500])),
            )),
      ),
    );
  }
}
