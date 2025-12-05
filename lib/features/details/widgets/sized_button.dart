import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const SizeButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        blur: 1,
        color: AppColors.primaryColor.withOpacity(.4),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : Colors.white,
          width: 1.5,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: isSelected ? AppColors.primaryColor : Colors.white,
          ),
        ),
      ),
    );
  }
}