import 'package:academe_mobile_new/core/helpers/regex.dart';
import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:academe_mobile_new/core/widgets/app_text_form.dart';
import 'package:academe_mobile_new/features/login/logic/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginFrom extends StatefulWidget {
  const LoginFrom({super.key});

  @override
  State<LoginFrom> createState() => _LoginFromState();
}

class _LoginFromState extends State<LoginFrom> {
  bool isObscure = true;
  bool haveId = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  double? drobdownheight;
  double? drobdownLevelheight;
  String? department;
  String? level;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LoginCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          CustomTextFrom(
            prefixText: haveId ? '@' : 'C',
            hintText: haveId ? 'Username' : 'ID',
            controller: cubit.idController,
            keyboardType: haveId ? TextInputType.text : TextInputType.number,
            validator: (value) {
              if (haveId) {
                if (value == null ||
                    value.isEmpty ||
                    !AppRegex.isValidUsername(cubit.idController.text) ||
                    value.length < 8) {
                  return 'Username includes only (a-z, A-Z, 0-9, _, -), at least 8 characters and no spaces';
                }
              } else {
                if (value == null ||
                    value.isEmpty ||
                    value.length != 7 ||
                    !AppRegex.isValidId(cubit.idController.text)) {
                  return 'Please enter valid ID';
                }
              }
              return null;
            },
          ),
          verticalSpace(20),
          GestureDetector(
            onTap: () {
              setState(() {
                haveId = !haveId;
              });
            },
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: haveId ? AppColors.mainColor : Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    Icons.check,
                    color: haveId ? Colors.white : Colors.grey,
                    size: 20,
                  ),
                ),
                horizontalSpace(10),
                Expanded(
                  child: Text.rich(TextSpan(
                      text: 'I don\'t have ID yet. ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 12.sp,
                          ),
                      children: [
                        TextSpan(
                            text:
                                'If you don\'t have ID, type your username above.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 12.sp,
                                  decoration: TextDecoration.underline,
                                )),
                      ])),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
