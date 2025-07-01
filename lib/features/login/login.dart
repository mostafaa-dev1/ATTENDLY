import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/networking/local_database/shared_preferances.dart';
import 'package:academe_mobile_new/core/routing/app_routes.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:academe_mobile_new/core/widgets/custom_button.dart';
import 'package:academe_mobile_new/core/widgets/have_not_have_account.dart';
import 'package:academe_mobile_new/core/widgets/sacffold_messinger.dart';
import 'package:academe_mobile_new/features/login/logic/login_cubit.dart';
import 'package:academe_mobile_new/features/login/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final String date = CashHelper.getString(key: 'date') ?? '';

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.pushNamedAndRemoveUntil(AppRoutes.home);
        } else if (state is LoginErorr) {
          scaffoldMessinger(
              context: context,
              message: state.error,
              icon: IconBroken.Info_Circle,
              isError: true);
        }
      },
      builder: (context, state) {
        var cubit = context.read<LoginCubit>();
        return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBar(
              title: Text('Login', style: theme.textTheme.headlineLarge),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello, Welcome Back 👋',
                        style: theme.textTheme.titleLarge!
                            .copyWith(color: AppColors.mainColor)),
                    Text('Happy to see you again, please login here',
                        style: theme.textTheme.headlineSmall),
                    verticalSpace(20),
                    const LoginFrom(),
                    verticalSpace(50),
                    Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                          width: MediaQuery.sizeOf(context).width / 1.5,
                          paddingHorizental: 10,
                          paddingVirtical: 5,
                          buttonName: 'Login',
                          isLoading:
                              state is LoginLoading || state is SignedInLoading,
                          onPressed: () {
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
                              // if (cubit.formKey.currentState!.validate()) {
                              //   cubit.isThisdeviceSignedIn();
                              // }
                            }
                            //cubit.isThisdeviceSignedIn();
                          },
                        )),
                    verticalSpace(20),
                    HaveAccount(
                      onTap: () {
                        context.pushNamed(AppRoutes.register);
                      },
                      text: 'Don\'t have an account?',
                      type: 'Register',
                    ),
                    verticalSpace(10),
                    HaveAccount(
                        onTap: () {
                          context.pushNamed(AppRoutes.lecturerLogin);
                        },
                        text: 'Login as a Lecturer?',
                        type: 'Lecturer'),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
