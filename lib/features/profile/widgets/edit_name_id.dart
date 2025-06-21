import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/helpers/regex.dart';
import 'package:academe_mobile_new/core/helpers/shared_functions.dart';
import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/logic/app_cubit.dart';
import 'package:academe_mobile_new/core/widgets/alert.dart';
import 'package:academe_mobile_new/core/widgets/app_text_form.dart';
import 'package:academe_mobile_new/core/widgets/custom_button.dart';
import 'package:academe_mobile_new/core/widgets/sacffold_messinger.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

class EditNameId extends StatefulWidget {
  const EditNameId({super.key});

  @override
  State<EditNameId> createState() => _EditNameIdState();
}

class _EditNameIdState extends State<EditNameId> {
  final nameController = TextEditingController();

  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AppCubit>();
    if (nameController.text.isEmpty) nameController.text = cubit.student!.name;
    if (idController.text.isEmpty) idController.text = cubit.student!.id;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is ChangeNameIDSuccess) {
          scaffoldMessinger(
              context: context,
              message: 'Changed successfully',
              icon: Icons.check,
              isError: false);
          context.pop();
        } else if (state is RequestSuccessState) {
          scaffoldMessinger(
              context: context,
              message: 'Request sent successfully',
              icon: Icons.check,
              isError: false);
          context.pop();
        } else if (state is RequestErrorState) {
          scaffoldMessinger(
              context: context,
              message: state.error,
              icon: Icons.check,
              isError: true);
        } else if (state is ChangeNameIDError) {
          scaffoldMessinger(
              context: context,
              message: state.error,
              icon: Icons.check,
              isError: true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Name and ID',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.orangeAccent)),
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Info_Circle,
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Note',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text.rich(TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'ID can not be changed, you can request',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                TextSpan(
                                  text: ' request to change it',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      showTextFormAlert(
                                          context, 'Request to change ID', () {
                                        context
                                            .read<AppCubit>()
                                            .requestTochangeID(
                                              cubit.student!.id,
                                              idController.text,
                                            );
                                      }, () {
                                        context.pop();
                                      }, 'Send', 'Cancel', idController);
                                    },
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        color: Colors.amber,
                                        decoration: TextDecoration.underline,
                                      ),
                                ),
                              ],
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                verticalSpace(20),
                CustomTextFrom(
                    hintText: 'Name',
                    controller: nameController,
                    validator: (v) {
                      if (v!.isEmpty ||
                          AppRegex.isEnglish(v) ||
                          SharedFunctions.spaces(v) < 4) {
                        return 'Please enter a valid name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text),
                verticalSpace(20),
                CustomTextFrom(
                    enabled: false,
                    hintText: 'ID',
                    controller: idController,
                    prefixText: 'C',
                    validator: (v) {
                      if (v!.isEmpty || v.length != 7) {
                        return 'Please enter a valid ID';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number),
                verticalSpace(20),
                CustomButton(
                    isLoading: state is ChangeNameIDLoading,
                    buttonName: 'Save',
                    onPressed: () {
                      cubit.changeNameID(nameController.text, cubit.student!.id,
                          idController.text);
                    },
                    width: MediaQuery.of(context).size.width / 2,
                    paddingVirtical: 10,
                    paddingHorizental: 20)
              ],
            ),
          ),
        );
      },
    );
  }
}
