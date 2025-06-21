// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:icon_broken/icon_broken.dart';
// import 'package:switcher_button/switcher_button.dart';

// class SubjectSettings extends StatelessWidget {
//   const SubjectSettings({super.key, required this.model, required this.index});
//   final SubjectCardModel model;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           model.name,
//           style: Theme.of(context).textTheme.headlineLarge,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 const Icon(
//                   IconBroken.Hide,
//                 ),
//                 horizontalSpace(15),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Hide subject',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     Text(
//                       'Hide subject from students',
//                       style: Theme.of(context).textTheme.bodySmall,
//                     ),
//                   ],
//                 ),
//                 const Spacer(),
//                 SwitcherButton(
//                   value: model.open == 1 ? true : false,
//                   onColor: AppColors.mainColor,
//                   offColor: Theme.of(context).colorScheme.secondary,
//                   onChange: (value) {
//                     context.read<AppCubit>().openSubjects(
//                         model.level, model.passcode, value, index);
//                   },
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
