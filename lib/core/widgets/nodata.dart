import 'package:flutter/material.dart';

class Nodata extends StatelessWidget {
  const Nodata({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/nodata.png',
            height: MediaQuery.sizeOf(context).width / 1.2,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
