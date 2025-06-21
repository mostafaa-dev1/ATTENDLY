import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/routing/app_routes.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:academe_mobile_new/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ItemLoading extends StatelessWidget {
  const ItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return item(context);
        },
        itemCount: 10,
      ),
    );
  }

  Widget item(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      child: GestureDetector(
        onTap: () {
          context.pushNamed(AppRoutes.studentInfo);
        },
        child: Container(
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
              leading: Image(
                image: const AssetImage('assets/images/boy.png'),
                height: 40.h,
              ),
              title: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  'Name',
                  style: theme.textTheme.headlineMedium),
              subtitle: Text('2100000',
                  style: AppTextStyles.style13w400g700.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.grey[500])),
              trailing: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
                  decoration: const BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Text('5',
                      style: AppTextStyles.style13Bb
                          .copyWith(color: Colors.white))),
            )),
      ),
    );
  }
}
