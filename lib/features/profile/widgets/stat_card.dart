import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      color: AppColors.primaryColor.withOpacity(.1),
      borderRadius: BorderRadius.circular(15.r),
      border: Border.all(color: AppColors.primaryColor.withOpacity(.2)),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 28.sp),
          Spacing.vSpace(8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

