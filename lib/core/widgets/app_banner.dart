// import 'package:flutter/material.dart';

// class AppBanner extends StatelessWidget {
//   const AppBanner({
//     super.key,
//     required this.bannerData,
//   });

//   final List<Map<String, dynamic>> bannerData;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.width > 500 ? 200 : 160,
//       child: Swiper(
//           autoplay: true,
//           itemCount: bannerData.length,
//           itemBuilder: (context, index) {
//             return banner(context, bannerData[index]);
//           }),
//     );
//   }
// }

// Widget banner(context, data) => Container(
//     height: MediaQuery.of(context).size.width > 500 ? 200 : 120,
//     padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
//     decoration: BoxDecoration(
//       gradient: const LinearGradient(colors: [
//         AppColors.mainColor,
//         Color.fromARGB(255, 0, 68, 195),
//       ]),
//       borderRadius: BorderRadius.circular(20),
//       //color: data['backgroundColor'],
//     ),
//     child: Row(
//       children: [
//         Expanded(
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               data['title'],
//               style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                   color: data['textColor'], fontSize: 20, height: 1.1),
//             ),
//             verticalSpace(10),
//             Text(
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 data['subtitle'],
//                 style: Theme.of(context)
//                     .textTheme
//                     .headlineSmall!
//                     .copyWith(color: data['textColor'])),
//             verticalSpace(10),
//             CustomButton(
//                 buttonName: data['buttonName'],
//                 onPressed: data['onPressed'],
//                 width: 100,
//                 backgroundColor: data['textColor'],
//                 buttonColor: data['backgroundColor'],
//                 fontSize: 12,
//                 paddingVirtical: 10,
//                 paddingHorizental: 10),
//           ]),
//         ),
//         data['isLottie']
//             ? Align(
//                 alignment: Alignment.bottomRight,
//                 child: Lottie.asset(data['image'],
//                     height: MediaQuery.sizeOf(context).width > 500
//                         ? 160
//                         : MediaQuery.sizeOf(context).width / 3.6),
//               )
//             : Image(
//                 image: AssetImage(
//                   data['image'],
//                 ),
//                 fit: BoxFit.fitHeight,
//                 height: MediaQuery.sizeOf(context).width > 500 ? 200 : 120,
//               ),
//       ],
//     ));
