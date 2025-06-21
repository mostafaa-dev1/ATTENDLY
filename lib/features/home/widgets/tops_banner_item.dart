// import 'package:academe_mobile/core/Constants/constants.dart';
// import 'package:academe_mobile/core/helpers/extentions.dart';
// import 'package:academe_mobile/core/helpers/spacing.dart';
// import 'package:academe_mobile/core/routing/app_routes.dart';
// import 'package:academe_mobile/core/widgets/profile_image.dart';
// import 'package:academe_mobile/features/home/data/model/tops_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class TopsItems extends StatefulWidget {
//   final bool isViewAll;
//   final double height;

//   const TopsItems({super.key, required this.isViewAll, required this.height});

//   @override
//   State<TopsItems> createState() => _TopsItemsState();
// }

// class _TopsItemsState extends State<TopsItems> {
//   late bool isAvailable;
//   DateTime? endDate;
//   @override
//   void initState() {
//     super.initState();
//     isAvailable = DateTime.friday != DateTime.now().weekday;
//     endDate = getNextFriday();
//   }

//   DateTime getNextFriday() {
//     DateTime now = DateTime.now();
//     int daysToAdd = (DateTime.friday - now.weekday + 7) % 7;
//     if (daysToAdd == 0) {
//       daysToAdd = 7;
//     }
//     DateTime nextFriday = now.add(Duration(days: daysToAdd));
//     return DateTime(nextFriday.year, nextFriday.month, nextFriday.day, 0, 0, 0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: isAvailable ? widget.height : 150.h,
//         padding: EdgeInsets.symmetric(horizontal: 10.w),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.primary,
//           border: Border.all(color: Theme.of(context).dividerColor, width: .5),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: bannarData(context, isAvailable, endDate!));
//   }

//   // Widget leaderBoardButton(BuildContext context) {
//   //   return Column(
//   //     mainAxisAlignment: MainAxisAlignment.center,
//   //     crossAxisAlignment: CrossAxisAlignment.center,
//   //     children: [
//   //       Row(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: [
//   //           const Icon(
//   //             IconBroken.Chart,
//   //             color: Colors.white,
//   //             size: 18,
//   //           ),
//   //           horizontalSpace(10),
//   //           Expanded(
//   //             child: Text(
//   //               maxLines: 2,
//   //               overflow: TextOverflow.ellipsis,
//   //               'Tops available now!',
//   //               style: Theme.of(context).textTheme.headlineSmall,
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //       verticalSpace(10),
//   //       CustomButton(
//   //           buttonName: 'View',
//   //           onPressed: () => context.pushNamed(AppRoutes.leaderboard),
//   //           width: 100,
//   //           paddingVirtical: 5,
//   //           fontSize: 12,
//   //           paddingHorizental: 10),
//   //     ],
//   //   );
//   // }

// //   Widget bannarData(BuildContext context, bool isAvailable, DateTime endDate) {
// //     return Center(
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //         crossAxisAlignment: CrossAxisAlignment.end,
// //         children: [
// //           horizontalSpace(10),
// //           Align(
// //             alignment: Alignment.bottomLeft,
// //             child: Image.asset(
// //               height: 100,
// //               'assets/images/top1.png',
// //             ),
// //           ),
// //           horizontalSpace(10),
// //           Expanded(
// //               child: isAvailable
// //                   ? leaderBoardButton(context)
// //                   : countDown(context, endDate)),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // Widget countDown(BuildContext context, DateTime endDate) {
// //   return Column(
// //     mainAxisAlignment: MainAxisAlignment.center,
// //     children: [
// //       Text(
// //         'Available after',
// //         style: Theme.of(context).textTheme.headlineMedium,
// //       ),
// //       TimerCountdown(
// //         enableDescriptions: false,
// //         timeTextStyle: Theme.of(context).textTheme.headlineSmall,
// //         format: CountDownTimerFormat.daysHoursMinutesSeconds,
// //         endTime: endDate,
// //         onEnd: () {},
// //       ),
// //     ],
// //   );
// // }

//   Widget topItem(
//       TopsModel model, double height, int index, BuildContext context) {
//     String id = Constants.id;
//     return Column(
//       children: [
//         Image(
//           image: AssetImage('assets/images/${index + 1}.png'),
//           height: 10,
//         ),
//         verticalSpace(5),
//         GestureDetector(
//           onTap: () {
//             // if (id != '' && id == model.users.userId) {
//             //   if (context.read<AppCubit>().profile.isEmpty) {
//             //     context.read<AppCubit>().getProfileData(id);
//             //   }
//             // } else {
//             //   context.read<AppCubit>().getPublicProfileData(model.users, id);
//             // }

//             context.pushNamed(
//               AppRoutes.profile,
//               arguments: id != '' && id != model.users.userId,
//             );
//           },
//           child: Container(
//             width: (MediaQuery.of(context).size.width / 4.02).h,
//             height: height,
//             margin: const EdgeInsets.symmetric(horizontal: 5),
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.secondary,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ProfileImage(
//                     imageUrl: model.users.image!,
//                     height: 40,
//                     width: 40,
//                     gender: model.users.gender),
//                 verticalSpace(5),
//                 Text(
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   model.users.name,
//                   style: Theme.of(context).textTheme.headlineSmall,
//                 ),
//                 verticalSpace(3),
//                 Text(model.points.toString(),
//                     style: Theme.of(context).textTheme.headlineSmall),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
