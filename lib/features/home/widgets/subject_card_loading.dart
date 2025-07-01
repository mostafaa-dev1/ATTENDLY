import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/routing/app_routes.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardLoading extends StatelessWidget {
  const CardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return loding(
            context,
          );
        },
        itemCount: 2,
      ),
    );
  }
}

Widget loding(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border.all(color: Theme.of(context).colorScheme.shadow),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                    'Subject',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
                  cardIcon(
                    () {
                      context.pushNamed(AppRoutes.quizzes);
                    },
                    CupertinoIcons.question_square,
                  ),
                ]),
                verticalSpace(5),
                Text('Computer Science',
                    style: Theme.of(context).textTheme.headlineLarge),
                verticalSpace(1),
                Text('CS24', style: Theme.of(context).textTheme.headlineSmall),
                verticalSpace(10),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Prof. Mahmoud Ali',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          'SAT, 10:00 AM - 11:00 AM',
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
                        border: Border.all(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      child: Text(
                        'Open',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: const Color.fromARGB(
                                  255,
                                  50,
                                  255,
                                  81,
                                ),
                                fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              border: Border.fromBorderSide(
                BorderSide(
                  color: Theme.of(context).colorScheme.shadow,
                  width: 1,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(AppRoutes.qr);
                    },
                    child: Row(
                      children: [
                        Text(
                          'QR Code',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.mainColor),
                        ),
                        horizontalSpace(5),
                        Icon(Icons.qr_code_2_rounded,
                            size: 15.h, color: AppColors.mainColor),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(AppRoutes.attendance);
                    },
                    child: Row(
                      children: [
                        Text(
                          'View more',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.mainColor),
                        ),
                        horizontalSpace(5),
                        Icon(IconBroken.Arrow___Right_2,
                            size: 15.h, color: AppColors.mainColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
GestureDetector cardIcon(
  VoidCallback? onTap,
  IconData icon,
) {
  return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: 23,
      ));
}
