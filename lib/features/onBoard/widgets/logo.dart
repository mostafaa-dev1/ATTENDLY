import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
            height: MediaQuery.sizeOf(context).width > 500 ? 80 : 60,
            image: const AssetImage('assets/images/logo.png')),
        horizontalSpace(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Academe', style: Theme.of(context).textTheme.bodyLarge),
            Text('Management system',
                style: Theme.of(context).textTheme.headlineSmall),
          ],
        )
      ],
    );
  }
}
