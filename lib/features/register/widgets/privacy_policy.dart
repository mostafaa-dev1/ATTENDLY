// import 'package:academe_mobile/core/themes/colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:url_launcher/url_launcher.dart';

// class PrivacyPolicy extends StatelessWidget {
//   final String mdFileName;
//   final String name;

//   const PrivacyPolicy(
//       {super.key, required this.mdFileName, required this.name});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(name, style: Theme.of(context).textTheme.headlineLarge),
//         ),
//         body: FutureBuilder(
//             future: Future.delayed(const Duration(milliseconds: 150)).then((v) {
//               return rootBundle.loadString('assets/$mdFileName.md');
//             }),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Markdown(
//                   styleSheet: MarkdownStyleSheet(
//                     p: Theme.of(context)
//                         .textTheme
//                         .headlineSmall!
//                         .copyWith(fontSize: 14),
//                   ),
//                   data: snapshot.data!,
//                   onTapLink: (text, href, title) {
//                     if (href != null) {
//                       launchUrl(Uri.parse(href));
//                     }
//                   },
//                 );
//               }
//               return Center(
//                   child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Please wait...',
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   ),
//                   const CupertinoActivityIndicator(
//                     color: AppColors.mainColor,
//                   )
//                 ],
//               ));
//             }));
//   }
// }
