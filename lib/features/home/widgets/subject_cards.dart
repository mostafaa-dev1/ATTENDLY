import 'package:academe_mobile_new/core/Constants/constants.dart';
import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/logic/app_cubit.dart';
import 'package:academe_mobile_new/core/models/student_model.dart';
import 'package:academe_mobile_new/core/networking/local_database/shared_preferances.dart';
import 'package:academe_mobile_new/core/routing/app_routes.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:academe_mobile_new/core/widgets/alert.dart';
import 'package:academe_mobile_new/core/widgets/nodata.dart';
import 'package:academe_mobile_new/features/home/data/model/card_model.dart';
import 'package:academe_mobile_new/features/home/data/model/subject_card_model.dart';
import 'package:academe_mobile_new/features/home/widgets/subject_card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';

class SubjectCards extends StatelessWidget {
  const SubjectCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        CardModel? data = context.read<AppCubit>().cardModel;

        var cubit = context.read<AppCubit>();
        String v = CashHelper.getString(key: 'version') ?? 'V2';
        bool updated = v == cubit.version;
        var student = context.read<AppCubit>().student;
        return state is GetDataLoadingState
            ? CardLoading()
            : data.cards.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CardItem(
                          card: data.cards[index],
                          index: index,
                          updated: updated,
                          student: student!);
                    },
                    itemCount: data.cards.length,
                  )
                : Center(
                    child: Column(
                      children: [
                        const Nodata(text: 'No Subjects Available'),
                      ],
                    ),
                  );
      },
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem(
      {super.key,
      required this.card,
      required this.index,
      required this.updated,
      required this.student});
  final SubjectCardModel card;
  final int index;
  final bool updated;
  final HomeStudentModel student;

  @override
  Widget build(BuildContext context) {
    bool isNowLecturer = context.read<AppCubit>().isNowLecturer(card: card);
    int length = context.read<AppCubit>().attendanceLength[card.passcode] ??
        Constants.attendanceLength(card.passcode);
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                right: 12.w, left: 12.w, top: 10.h, bottom: 5.h),
            width: double.infinity,
            margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Theme.of(context).colorScheme.shadow),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                    'Subject',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Spacer(),
                  student.department == 'Lecturer'
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color: Theme.of(context).dividerColor),
                          ),
                          child: Text(
                            length.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: AppColors.mainColor, fontSize: 13),
                          ),
                        )
                      : const SizedBox(),
                  student.department == 'Lecturer'
                      ? horizontalSpace(5)
                      : const SizedBox(),
                  student.department == 'Lecturer'
                      ? cardIcon(
                          () {
                            context.pushNamed(AppRoutes.subjectSettings,
                                arguments: {'model': card, 'index': index});
                          },
                          IconBroken.Setting,
                        )
                      : const SizedBox(),
                ]),
                verticalSpace(5),
                Text(card.name, style: Theme.of(context).textTheme.bodyMedium),
                verticalSpace(1),
                Text(card.level,
                    style: Theme.of(context).textTheme.headlineSmall),
                verticalSpace(10),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Prof. ${card.doctor}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          '${card.day}-${card.start}-${card.end}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Theme.of(context).dividerColor),
                      ),
                      child: Text(
                        card.open == 1
                            ? 'Open'
                            : isNowLecturer
                                ? 'Active'
                                : 'Closed',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: card.open == 1
                                    ? AppColors.mainColor
                                    : isNowLecturer
                                        ? AppColors.appGreen
                                        : AppColors.appRed,
                                fontSize: 10),
                      ),
                    ),
                  ],
                ),
                verticalSpace(5),
                Divider(
                  color: Theme.of(context).dividerColor,
                ),
                Row(
                  mainAxisAlignment: !student.isAdmin
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceAround,
                  children: [
                    if (student.isAdmin)
                      GestureDetector(
                        onTap: () {
                          if (student.isBlocked || !updated) {
                            showAlert(
                              context,
                              !updated ? 'Update required' : 'Blocked',
                              !updated
                                  ? 'Please update the app'
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
                            if (student.isAdmin || student.isSuperAdmin) {
                              context.pushNamed(AppRoutes.scanningSettings,
                                  arguments: card);
                            }
                          }
                        },
                        child: Container(
                          color: Colors.transparent,
                          height: 25,
                          width: 100.w,
                          child: Icon(
                              student.isAdmin || student.isSuperAdmin
                                  ? IconBroken.Scan
                                  : Icons.qr_code_2_rounded,
                              size: 15.h),
                        ),
                      ),
                    if (student.isAdmin)
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutes.cashedAttendance,
                              arguments: card);
                        },
                        child: Container(
                          color: Colors.transparent,
                          height: 25,
                          width: 100.w,
                          child: Icon(IconBroken.Upload, size: 15.h),
                        ),
                      ),
                    GestureDetector(
                      onTap: () {
                        if (student.isBlocked || !updated) {
                          showAlert(
                              context,
                              !updated ? 'Update required' : 'Blocked',
                              !updated
                                  ? 'Please update the app'
                                  : 'You are blocked from using the app', () {
                            context.pop();
                          }, () {
                            context.pop();
                          }, 'OK', 'Cancel', IconBroken.Info_Circle, false, '');
                        } else {
                          if (student.isAdmin) {
                            context.read<AppCubit>().getStudents(card);
                            context.pushNamed(AppRoutes.attendance,
                                arguments: card);
                          } else if (card.open == 1) {
                            context.read<AppCubit>().getStudentsAttendance(
                                card.level, card.passcode, Constants.id);
                            context.pushNamed(AppRoutes.studentAttendance);
                          } else {
                            showAlert(context, 'Subject Closed',
                                'This subject is closed by the lecturer, you can not show your attendance',
                                () {
                              context.pop();
                            }, () {
                              context.pop();
                            }, 'Ok', 'Close', IconBroken.Info_Circle, false,
                                '');
                          }
                        }
                      },
                      child: Container(
                          color: Colors.transparent,
                          height: 25,
                          width: 100.w,
                          child: Icon(IconBroken.Arrow___Right_2, size: 15.h)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
