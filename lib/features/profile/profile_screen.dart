// ignore_for_file: must_be_immutable

import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/helpers/images_helpers.dart';
import 'package:academe_mobile_new/core/helpers/shared_functions.dart';
import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/logic/app_cubit.dart';
import 'package:academe_mobile_new/core/models/student_model.dart';
import 'package:academe_mobile_new/core/routing/app_routes.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:academe_mobile_new/core/widgets/alert.dart';
import 'package:academe_mobile_new/core/widgets/sacffold_messinger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Profile extends StatelessWidget {
  const Profile({
    super.key,
    required this.publicProfile,
  });
  final bool publicProfile;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is GetProfileDataErrorState) {
          scaffoldMessinger(
            context: context,
            message: state.error,
            icon: Icons.error,
            isError: true,
          );
        } else if (state is UpdateProfileImageErrorState) {
          scaffoldMessinger(
            context: context,
            message: state.error,
            icon: Icons.error,
            isError: true,
          );
        } else if (state is Logout) {
          context.pushNamedAndRemoveUntil(AppRoutes.login);
        }
      },
      builder: (context, state) {
        var cubit = context.read<AppCubit>();
        HomeStudentModel? data = cubit.profileData;
        return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBar(
              title: Text('Profile',
                  style: Theme.of(context).textTheme.headlineLarge),
            ),
            body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Skeletonizer(
                    enabled: state is GetProfileDataLoadingState,
                    child: Column(children: [
                      Stack(
                        children: [
                          Skeletonizer(
                            enabled: state is UpdateProfileImageLoadingState ||
                                state is UpdateProfileDataLoadingState,
                            child: CircleAvatar(
                              radius: 55.r,
                              backgroundImage: data.image != ''
                                  ? NetworkImage(data.image!) as ImageProvider
                                  : AssetImage(
                                      ImagesHelpers.genderImage(data.gender)),
                            ),
                          ),
                          cubit.student!.id != data.id
                              ? const SizedBox()
                              : Positioned(
                                  bottom: 0,
                                  right: 3,
                                  child:
                                      bottomSheet(context, theme, cubit, data),
                                ),
                        ],
                      ),
                      verticalSpace(10),
                      Skeletonizer(
                        enabled: state is UpdateProfileImageLoadingState,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    SharedFunctions.split(data.name),
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyMedium),
                                horizontalSpace(5),
                                data.id == 'A'
                                    ? const Icon(
                                        Icons.verified,
                                        color: AppColors.mainColor,
                                      )
                                    : const SizedBox()
                              ],
                            ),
                            publicProfile
                                ? const SizedBox()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('@${data.id}',
                                          style: theme.textTheme.headlineSmall),
                                      Text(data.isAdmin ? ' (Admin)' : '',
                                          style: theme.textTheme.headlineSmall),
                                    ],
                                  ),
                            verticalSpace(5),
                          ],
                        ),
                      ),
                      verticalSpace(50),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutes.editNameId);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                      color: theme.colorScheme.shadow,
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 5))
                                ]),
                            child: Row(children: [
                              const Icon(
                                IconBroken.Profile,
                              ),
                              horizontalSpace(10),
                              Text('Edit Name and ID',
                                  style: theme.textTheme.bodyMedium),
                              const Spacer(),
                              const Icon(IconBroken.Arrow___Right_2)
                            ])),
                      ),
                      verticalSpace(10),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutes.about);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                      color: theme.colorScheme.shadow,
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 5))
                                ]),
                            child: Row(children: [
                              Icon(
                                IconBroken.Info_Circle,
                              ),
                              horizontalSpace(10),
                              Text('About', style: theme.textTheme.bodyMedium),
                              const Spacer(),
                              const Icon(IconBroken.Arrow___Right_2)
                            ])),
                      ),
                      verticalSpace(10),
                      GestureDetector(
                        onTap: () {
                          showAlert(
                              context,
                              'You can\'t login again before 1 hour',
                              'Are you sure you want to logout?', () {
                            cubit.logout();
                          }, () {
                            context.pop();
                          }, 'Yes', 'Cancel', IconBroken.Info_Circle, false,
                              null);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                      color: theme.colorScheme.shadow,
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 5))
                                ]),
                            child: Row(children: [
                              Icon(
                                IconBroken.Logout,
                                color: AppColors.appRed,
                              ),
                              horizontalSpace(10),
                              Text('Logout',
                                  style: theme.textTheme.bodyMedium!
                                      .copyWith(color: AppColors.appRed)),
                            ])),
                      ),
                      verticalSpace(10),
                      GestureDetector(
                        onTap: () {
                          showAlert(
                              context,
                              'You can\'t carete account or login again before 1 hour',
                              'Are you sure you want to delete your account?',
                              () {
                            cubit.deleteAccount();
                          }, () {
                            context.pop();
                          }, 'Yes', 'Cancel', IconBroken.Info_Circle, false,
                              null);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                      color: theme.colorScheme.shadow,
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 5))
                                ]),
                            child: Row(children: [
                              Icon(
                                IconBroken.Delete,
                                color: AppColors.appRed,
                              ),
                              horizontalSpace(10),
                              Text('Delete Account',
                                  style: theme.textTheme.bodyMedium!
                                      .copyWith(color: AppColors.appRed)),
                            ])),
                      ),
                    ]),
                  ),
                )));
      },
    );
  }

  GestureDetector bottomSheet(BuildContext context, ThemeData theme,
      AppCubit cubit, HomeStudentModel data) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      verticalSpace(20),
                      GestureDetector(
                        onTap: () {
                          context.pop();
                          cubit.uploadProfileImage();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconBroken.Edit,
                                  color: AppColors.mainColor,
                                ),
                                horizontalSpace(10),
                                Text('Change',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ]),
                        ),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: () {
                          showAlert(context, 'Delete Profile',
                              'Are you sure you want to delete your profile ?',
                              () {
                            context.pop();
                            cubit.deleteImage();
                          }, () {
                            context.pop();
                          }, 'Delete', 'Cancel', IconBroken.Delete, false, '');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Delete,
                                color: AppColors.mainColor,
                              ),
                              horizontalSpace(10),
                              Text(
                                'Delete',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
      },
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          data.image != '' ? IconBroken.Edit : IconBroken.Camera,
          color: AppColors.mainColor,
        ),
      ),
    );
  }
}
