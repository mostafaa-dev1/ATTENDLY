import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/features/onBoard/widgets/login_register_buttons.dart';
import 'package:academe_mobile_new/features/onBoard/widgets/logo.dart';
import 'package:academe_mobile_new/features/onBoard/widgets/welcome.dart';
import 'package:flutter/material.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/b2.png'),
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Logo(),
                  verticalSpace(20),
                  const Welcome(),
                  verticalSpace(20),
                  const LoginRegisterButtons()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
