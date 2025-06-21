import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:academe_mobile_new/core/themes/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme = ThemeData(
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: AppColors.mainColor,
    applyThemeToAll: true,
  ),
  textTheme: TextTheme(
    headlineLarge: AppTextStyles.style18Bb.copyWith(color: Colors.white),
    headlineMedium: AppTextStyles.style14Bb.copyWith(color: Colors.white),
    headlineSmall: AppTextStyles.style13w400g700.copyWith(color: Colors.white),
    bodyMedium: AppTextStyles.style16Bb.copyWith(color: Colors.white),
    bodyLarge: AppTextStyles.style25Bb.copyWith(color: Colors.white),
    titleLarge: AppTextStyles.style27Bb.copyWith(color: Colors.white),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
    iconColor: WidgetStateProperty.all(Colors.white),
  )),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStateProperty.all(Colors.white),
    ),
  ),
  canvasColor: Colors.white,
  brightness: Brightness.dark,
  cardColor: Colors.grey[850],
  highlightColor: Colors.grey[850],
  dividerColor: Colors.grey[800],
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: AppColors.mainColor,
    primary: Colors.grey[850],
    background: Colors.grey[900],
    secondary: Colors.grey[800],
    shadow: Colors.grey[900],
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.grey[900],
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
  ),
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF151515),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF151515),
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarContrastEnforced: true,
      )),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: AppColors.mainColor, // Color of the selection background
    cursorColor: AppColors.mainColor, // Color of the cursor
    // Color of the selection handles
  ),
);
