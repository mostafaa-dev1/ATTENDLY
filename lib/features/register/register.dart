import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/networking/local_database/shared_preferances.dart';
import 'package:academe_mobile_new/core/routing/app_routes.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:academe_mobile_new/core/widgets/custom_button.dart';
import 'package:academe_mobile_new/core/widgets/have_not_have_account.dart';
import 'package:academe_mobile_new/core/widgets/sacffold_messinger.dart';
import 'package:academe_mobile_new/features/register/logic/register_cubit.dart';
import 'package:academe_mobile_new/features/register/widgets/registration_forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';

class Register extends StatelessWidget {
  Register({super.key});
  final String date = CashHelper.getString(key: 'date') ?? '';

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var cubit = context.read<RegisterCubit>();
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterErorr) {
          scaffoldMessinger(
              context: context,
              message: state.error,
              icon: IconBroken.Info_Circle,
              isError: true);
        } else if (state is RegisterSuccess) {
          context.pushNamedAndRemoveUntil(AppRoutes.home);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(
              'Register',
              style: theme.textTheme.headlineLarge,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello, Welcome 👋',
                      style: theme.textTheme.titleLarge!
                          .copyWith(color: AppColors.mainColor)),
                  Text('First, let\'s create your account',
                      style: theme.textTheme.headlineSmall),
                  verticalSpace(30),
                  const RegistrationForms(),
                  verticalSpace(20),
                  Align(
                      alignment: Alignment.center,
                      child: CustomButton(
                        width: MediaQuery.sizeOf(context).width / 1.5,
                        paddingHorizental: 10,
                        paddingVirtical: 5,
                        buttonName: 'Register',
                        isLoading: state is IsIdFoundLoading ||
                            state is RegisterLoading,
                        onPressed: () async {
                          if (date != '' &&
                              DateTime.now().isBefore(DateTime.parse(date)
                                  .add(const Duration(hours: 1)))) {
                            scaffoldMessinger(
                              context: context,
                              message: cubit.diffrence(DateTime.parse(date)),
                              icon: IconBroken.Info_Circle,
                              isError: true,
                            );
                          } else {
                            if (context
                                .read<RegisterCubit>()
                                .formKey
                                .currentState!
                                .validate()) {
                              cubit.isIdfound();
                            }
                          }
                        },
                      )),
                  // verticalSpace(10),
                  // const Align(
                  //   alignment: Alignment.center,
                  //   child: PrivacyAndPolicy(
                  //     text: 'registering',
                  //   ),
                  // ),
                  verticalSpace(20),
                  HaveAccount(
                      onTap: () {
                        context.pushNamed(AppRoutes.login);
                      },
                      text: 'Already have an account?',
                      type: 'Login'),
                  verticalSpace(10),
                  // HaveAccount(
                  //     onTap: () {
                  //       context.pushNamed(AppRoutes.lecturerLogin);
                  //     },
                  //     text: 'Register as a Lecturer?',
                  //     type: 'Lecturer'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
