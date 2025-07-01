import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildAppTheme({required String locale, required bool isDark}) {
  final baseTheme = isDark ? ThemeData.dark() : ThemeData.light();

  return baseTheme.copyWith(
      textTheme: locale == 'ar'
          ? buildArabicTextTheme(isDark)
          : buildEnglishTextTheme(isDark),
      scaffoldBackgroundColor: isDark ? Colors.grey[900] : Colors.white,
      primaryColor: AppColors.mainColor,
      cardColor: isDark ? Colors.grey[850] : Colors.white,
      highlightColor: isDark ? Colors.grey[800] : Colors.grey[200],
      dividerColor: isDark ? Colors.grey[700] : Colors.grey[300],
      iconTheme:
          IconThemeData(color: isDark ? Colors.white : AppColors.appBlack),
      shadowColor: isDark ? Colors.grey[900] : Colors.grey[100],
      appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: isDark ? Colors.grey[900] : Colors.white,
          surfaceTintColor: Colors.transparent,
          iconTheme:
              IconThemeData(color: isDark ? Colors.white : AppColors.appBlack),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
            statusBarColor: isDark ? Colors.grey[900] : Colors.white,
            statusBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: isDark ? Colors.grey[900] : Colors.white,
            systemNavigationBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
          )),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppColors.mainColor,
        cursorColor: AppColors.mainColor,
        selectionColor: AppColors.mainColor,
      ));
}

TextTheme buildEnglishTextTheme(bool isDark) => TextTheme(
      headlineLarge:
          GoogleFonts.poppins(fontSize: 32.sp, fontWeight: FontWeight.bold)
              .withThemeColor(isDark),
      headlineMedium:
          GoogleFonts.poppins(fontSize: 28.sp, fontWeight: FontWeight.bold)
              .withThemeColor(isDark),
      headlineSmall:
          GoogleFonts.poppins(fontSize: 24.sp, fontWeight: FontWeight.bold)
              .withThemeColor(isDark),
      titleLarge:
          GoogleFonts.poppins(fontSize: 22.sp, fontWeight: FontWeight.bold)
              .withThemeColor(isDark),
      titleMedium:
          GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.bold)
              .withThemeColor(isDark),
      titleSmall:
          GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.bold)
              .withThemeColor(isDark),
      bodyLarge:
          GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.bold)
              .withThemeColor(isDark),
      bodyMedium:
          GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.bold)
              .withThemeColor(isDark),
      bodySmall:
          GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.bold)
              .withThemeColor(isDark),
      labelLarge: GoogleFonts.poppins(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.mainColor),
      labelMedium:
          GoogleFonts.poppins(fontSize: 10.sp, fontWeight: FontWeight.w400)
              .withThemeColor(isDark),
      labelSmall:
          GoogleFonts.poppins(fontSize: 8.sp, fontWeight: FontWeight.w400)
              .withThemeColor(isDark),
    );

TextTheme buildArabicTextTheme(bool isDark) => TextTheme(
      headlineLarge:
          GoogleFonts.cairo(fontSize: 32.sp, fontWeight: FontWeight.bold)
              .withThemeColor(isDark),
      headlineMedium:
          GoogleFonts.cairo(fontSize: 28.sp, fontWeight: FontWeight.bold)
              .withThemeColor(isDark),
      headlineSmall:
          GoogleFonts.cairo(fontSize: 24.sp, fontWeight: FontWeight.bold)
              .withThemeColor(isDark),
      titleLarge:
          GoogleFonts.cairo(fontSize: 22.sp, fontWeight: FontWeight.bold)
              .withThemeColor(isDark),
      titleMedium:
          GoogleFonts.cairo(fontSize: 16.sp, fontWeight: FontWeight.bold)
              .withThemeColor(isDark),
      titleSmall:
          GoogleFonts.cairo(fontSize: 14.sp, fontWeight: FontWeight.bold)
              .withThemeColor(isDark),
      bodyLarge: GoogleFonts.cairo(fontSize: 16.sp, fontWeight: FontWeight.bold)
          .withThemeColor(isDark),
      bodyMedium:
          GoogleFonts.cairo(fontSize: 14.sp, fontWeight: FontWeight.bold)
              .withThemeColor(isDark),
      bodySmall: GoogleFonts.cairo(fontSize: 12.sp, fontWeight: FontWeight.bold)
          .withThemeColor(isDark),
      labelLarge: GoogleFonts.cairo(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.mainColor),
      labelMedium:
          GoogleFonts.cairo(fontSize: 10.sp, fontWeight: FontWeight.w400)
              .withThemeColor(isDark),
      labelSmall: GoogleFonts.cairo(fontSize: 8.sp, fontWeight: FontWeight.w400)
          .withThemeColor(isDark),
    );
