import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/helpers/images_helpers.dart';
import 'package:academe_mobile_new/core/logic/app_cubit.dart';
import 'package:academe_mobile_new/core/routing/app_routes.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:academe_mobile_new/core/themes/text_styles.dart';
import 'package:academe_mobile_new/core/widgets/nodata.dart';
import 'package:academe_mobile_new/features/attendance/model/student_model.dart';
import 'package:academe_mobile_new/features/attendance/widgets/item_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendanceItem extends StatelessWidget {
  const AttendanceItem({super.key, required this.subjectName});
  final String subjectName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        var model = context.read<AppCubit>().studentsModel;
        return state is ExportCachedStudentsLoadingState
            ? const Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.mainColor,
                ),
              )
            : state is ExportCachedStudentsSuccessState
                ? Center(
                    child: Text('Successfully Exported',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: AppColors.mainColor,
                                )),
                  )
                : state is GetStudentsLoadingState
                    ? const ItemLoading()
                    : model!.students.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                    'Total Students : ${model.students.length}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return item(context, model.students[index]);
                                  },
                                  itemCount: model.students.length,
                                ),
                              ),
                            ],
                          )
                        : const Center(
                            child: Nodata(text: 'No Students Available'));
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
              trailing: model.attendance != null
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
                      decoration: const BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Text(model.attendance.toString(),
                          style: AppTextStyles.style13Bb
                              .copyWith(color: Colors.white)))
                  : const SizedBox(),
            )),
      ),
    );
  }
}
