import 'dart:ui';
import 'package:caffeine/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget glassContainer({required Widget child}) {
  return Container(height: 340.h,width: 400.w,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(18.r),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.secondaryColor.withOpacity(0.2),
          AppColors.secondaryColor.withOpacity(0.2),
          AppColors.secondaryColor.withOpacity(0.1),
        ],
      ),
    ),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(18.r),
          color: Colors.white.withOpacity(0.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 80.r,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        padding:  EdgeInsets.symmetric(horizontal: 18.w, vertical: 0),
        child: child,
      ),
    ),
  );
}