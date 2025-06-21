import 'package:academe_mobile_new/core/helpers/images_helpers.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage(
      {super.key,
      required this.imageUrl,
      required this.height,
      required this.width,
      required this.gender});

  final String imageUrl;
  final double height;
  final double width;
  final String gender;

  @override
  Widget build(BuildContext context) {
    return imageUrl != ''
        ? Container(
            width: width,
            height: height,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image(
              image: NetworkImage(imageUrl),
              fit: BoxFit.fill,
            ),
          )
        : CircleAvatar(
            backgroundImage: AssetImage(ImagesHelpers.genderImage(gender)),
          );
  }
}
