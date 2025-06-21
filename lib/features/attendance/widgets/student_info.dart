import 'package:academe_mobile_new/core/helpers/images_helpers.dart';
import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/logic/app_cubit.dart';
import 'package:academe_mobile_new/features/attendance/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentInfo extends StatelessWidget {
  const StudentInfo({super.key, required this.data});
  final StudentModel data;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text('Student info', style: theme.textTheme.headlineLarge),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.shadow,
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset:
                              const Offset(0, 4), // changes position of shadow
                        ),
                      ]),
                  child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      leading: Image(
                          image: AssetImage(
                              ImagesHelpers.genderImage(data.gender))),
                      title: Text(data.name!,
                          style: theme.textTheme.headlineMedium),
                      subtitle:
                          Text(data.id!, style: theme.textTheme.headlineSmall)),
                ),
                verticalSpace(10),
                Row(children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.shadow,
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: const Offset(
                                  0, 4), // changes position of shadow
                            ),
                          ]),
                      child: Row(
                        children: [
                          const Image(
                              height: 40,
                              image: AssetImage('assets/images/user.png')),
                          horizontalSpace(10),
                          Container(
                            width: 1,
                            height: 40,
                            color: Colors.grey[300],
                          ),
                          horizontalSpace(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Attendance',
                                  style: theme.textTheme.headlineSmall),
                              Text(data.attendance.toString(),
                                  style: theme.textTheme.headlineMedium),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                verticalSpace(10),
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.shadow,
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(
                                0, 4), // changes position of shadow
                          ),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Attendance Dates',
                            style: theme.textTheme.headlineLarge),
                        verticalSpace(10),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.dates!.length,
                            itemBuilder: (context, index) {
                              return Text(
                                data.dates![index].toString(),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              );
                            }),
                      ],
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
