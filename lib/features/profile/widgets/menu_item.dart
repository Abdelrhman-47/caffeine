import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;

  const MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: AppColors.primaryColor, size: 22.sp),
            ),
            Spacing.hSpace(15.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            trailing ??
                Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
