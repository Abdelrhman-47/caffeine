import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputField extends StatelessWidget {
    final String label;
    final TextEditingController controller;
    final IconData icon;
    final String hint;
    final bool readOnly;
    final Widget? suffixIcon;
  
    const InputField({
      required this.label,
      required this.controller,
      required this.icon,
      required this.hint,
      this.readOnly = false,
      this.suffixIcon,
    });
  
    @override
    Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          Spacing.vSpace(10.h),
          Container(
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
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              style: TextStyle(
                fontSize: 16.sp,
                color: readOnly ? Colors.grey : Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(
                  icon,
                  color: AppColors.primaryColor.withOpacity(.7),
                  size: 22.sp,
                ),
                suffixIcon: suffixIcon,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: readOnly ? Colors.grey[50] : Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }