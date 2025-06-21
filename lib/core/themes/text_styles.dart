import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle style13w400g700 = GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: Colors.grey[700],
  );
  static TextStyle style13Bb = GoogleFonts.poppins(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle style16Bw = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static TextStyle style16Bb = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle style14Bb = GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle style16Bc = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.mainColor,
  );
  static TextStyle style18Bb = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle style27Bc = GoogleFonts.poppins(
      fontSize: 27.sp, fontWeight: FontWeight.bold, color: AppColors.mainColor);
  static TextStyle style27Bb = GoogleFonts.poppins(
      fontSize: 27.sp, fontWeight: FontWeight.bold, color: Colors.black);

  static TextStyle style20Bc = GoogleFonts.poppins(
      fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.mainColor);
  static TextStyle style20Bb = GoogleFonts.poppins(
      fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle style25Bb =
      GoogleFonts.poppins(fontSize: 25.sp, fontWeight: FontWeight.bold);
}
