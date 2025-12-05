import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryRow extends StatelessWidget {
  CategoryRow({super.key});
  final List<String> category = [
    'All Coffee',
    'Machiato',
    'Latte',
    'Americano',
    'Cappuccino',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...List.generate(category.length, (index) {
            return Padding(
              padding: EdgeInsets.only(left: 7.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                    height: 35.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: AppColors.primaryColor,
                    ),
                    child: Text(
                      category[index],
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacing.hSpace(1.w),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
