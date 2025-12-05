import 'package:caffeine/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static TextStyle skipStyle = GoogleFonts.merriweather(
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white.withOpacity(.4),
  );
  static TextStyle nextbutton = GoogleFonts.merriweather(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
  static TextStyle headLineStyle = GoogleFonts.merriweather(
    color: Colors.white,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle supTitleStyle = GoogleFonts.merriweather(
                      color: Colors.white.withOpacity(.6),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    );
  static TextStyle signUpStyle = GoogleFonts.merriweather(
                    
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                
                    );
}
