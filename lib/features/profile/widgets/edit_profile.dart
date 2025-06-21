// import 'package:flutter/material.dart';

// class EditProfile extends StatelessWidget {
//   EditProfile({super.key, required this.name, required this.id});
//   final String name;
//   final String id;
//   final nameController = TextEditingController();
//   final idController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     nameController.text = name;
//     idController.text = id;
//     String department = Constants.department;
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         children: [
//           CustomTextFrom(
//             hintText: 'New Name',
//             controller: nameController,
//             keyboardType: TextInputType.name,
//           ),
//           verticalSpace(20),
//           CustomTextFrom(
//             hintText: 'New ID',
//             controller: idController,
//             keyboardType: TextInputType.number,
//             prefixText: 'C',
//           ),
//           verticalSpace(40),
//           department == 'Other'
//               ? const SizedBox()
//               : CustomButton(
//                   buttonName: 'Save',
//                   onPressed: () {
//                     // context.read<ProfileCubit>().updateProfileData({
//                     //   'name': nameController.text,
//                     //   'id': idController.text,
//                     // });
//                   },
//                   width: 200,
//                   paddingVirtical: 10,
//                   paddingHorizental: 10,
//                 )
//         ],
//       ),
//     );
//   }
// }
