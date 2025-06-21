import 'package:academe_mobile_new/core/helpers/regex.dart';
import 'package:academe_mobile_new/core/helpers/shared_functions.dart';
import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:academe_mobile_new/core/widgets/app_text_form.dart';
import 'package:academe_mobile_new/core/widgets/custom_dropdown.dart';
import 'package:academe_mobile_new/features/register/logic/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationForms extends StatefulWidget {
  const RegistrationForms({super.key});

  @override
  State<RegistrationForms> createState() => _RegistrationFormsState();
}

class _RegistrationFormsState extends State<RegistrationForms> {
  // bool hasUppercase = false;
  // bool hasLowercase = false;
  // bool hasNumber = false;
  // bool hasSpecialCharacter = false;
  // bool hasLength = false;
  // bool obscureText = true;
  // late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    // passwordController = context.read<RegisterCubit>().passwordController;

    // passwordController.addListener(() {
    //   setState(() {
    //     hasUppercase = AppRegex.hasUpperCase(passwordController.text);
    //     hasLowercase = AppRegex.hasLowerCase(passwordController.text);
    //     hasNumber = AppRegex.hasNumber(passwordController.text);
    //     hasSpecialCharacter =
    //         AppRegex.hasSpecialCharacter(passwordController.text);
    //     hasLength = passwordController.text.length >= 8;
    //   });
    // });
  }

  @override
  void dispose() {
    super.dispose();
    // passwordController.dispose();
  }

  double? drobdownheight;
  double? drobdownLevelheight;
  bool? haveId = false;

  String? department;
  String? level;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegisterCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCustomDropDown(
              list: const ['CS', 'IS', 'Other'],
              width: MediaQuery.sizeOf(context).width,
              height: drobdownheight ?? 50,
              text: 'Department',
              hintText: 'Select department',
              onChanged: (c) {
                cubit.department = c!;
                setState(() {
                  department = c;
                });
                return null;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  setState(() {
                    drobdownheight = 65;
                  });
                  return 'Please select department';
                }
                return null;
              }),
          verticalSpace(10),
          department == 'Other'
              ? verticalSpace(0)
              : AppCustomDropDown(
                  list: const ['Level1', 'Level2', 'Level3', 'Level4'],
                  width: MediaQuery.sizeOf(context).width,
                  height: drobdownLevelheight ?? 50,
                  text: 'Level',
                  hintText: 'Select level',
                  onChanged: (c) {
                    cubit.level = c!;
                    setState(() {
                      level = c;
                    });
                    return null;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        drobdownLevelheight = 65;
                      });
                      return 'Please select Level';
                    }
                    return null;
                  }),
          department == 'Other' || department == 'IS'
              ? verticalSpace(0)
              : verticalSpace(10),
          CustomTextFrom(
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEnglish(cubit.nameController.text) ||
                  SharedFunctions.spaces(cubit.nameController.text) <
                      (department == 'Other' ? 2 : 4)) {
                return 'Please enter valid name with at least 4 names with English letters';
              }
              return null;
            },
            hintText: department == 'Other' ? 'Name' : 'Full name',
            controller: cubit.nameController,
            keyboardType: TextInputType.name,
          ),
          verticalSpace(15),
          GestureDetector(
            onTap: () {
              setState(() {
                haveId = !haveId!;
              });
            },
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: haveId! ? AppColors.mainColor : Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    Icons.check,
                    color: haveId! ? Colors.white : Colors.grey,
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
                                'If you don\'t have ID, type your username below.',
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
          verticalSpace(15),
          CustomTextFrom(
            validator: (value) {
              if (department == 'Other' || haveId!) {
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
            hintText: department == 'Other' || haveId! ? 'Username' : 'ID',
            controller: cubit.idController,
            keyboardType: department == 'Other' || haveId!
                ? TextInputType.text
                : TextInputType.number,
            prefixText: department == 'Other' || haveId! ? '@' : 'C',
          ),
          verticalSpace(10),
          AppCustomDropDown(
              text: 'Gender',
              list: const ['Male', 'Female'],
              width: MediaQuery.sizeOf(context).width,
              hintText: 'Select gender',
              onChanged: (c) {
                cubit.gender = c!;
                return null;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  setState(() {
                    drobdownheight = 65;
                  });
                  return 'Please select gender';
                }
                return null;
              },
              height: drobdownheight ?? 50),
          verticalSpace(20),
        ],
      ),
    );
  }
}
