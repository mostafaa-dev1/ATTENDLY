// import 'package:academe_mobile/core/helpers/extentions.dart';
// import 'package:academe_mobile/core/routing/app_routes.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';

// class PrivacyAndPolicy extends StatelessWidget {
//   final String text;
//   const PrivacyAndPolicy({super.key, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return RichText(
//         textAlign: TextAlign.center,
//         text: TextSpan(
//           text: 'By $text you agree to our ',
//           style: Theme.of(context).textTheme.headlineSmall,
//           children: <TextSpan>[
//             TextSpan(
//               text: 'Terms & Conditions',
//               style: Theme.of(context)
//                   .textTheme
//                   .headlineSmall!
//                   .copyWith(fontWeight: FontWeight.bold),
//               recognizer: TapGestureRecognizer()
//                 ..onTap = () {
//                   context.pushNamed(AppRoutes.privacypolicy, arguments: {
//                     'name': 'Terms & Conditions',
//                     'privacyPolicy': 'terms_conditions_text'
//                   });
//                 },
//             ),
//             TextSpan(
//                 text: ' and ',
//                 style: Theme.of(context).textTheme.headlineSmall),
//             TextSpan(
//               text: 'Privacy Policy',
//               style: Theme.of(context)
//                   .textTheme
//                   .headlineSmall!
//                   .copyWith(fontWeight: FontWeight.bold),
//               recognizer: TapGestureRecognizer()
//                 ..onTap = () {
//                   context.pushNamed(AppRoutes.privacypolicy, arguments: {
//                     'name': 'Privacy Policy',
//                     'privacyPolicy': 'privacy_policy_text'
//                   });
//                 },
//             ),
//           ],
//         ));
//   }
// }
