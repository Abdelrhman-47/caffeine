import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SliderComponent extends StatelessWidget {
  const SliderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return DarkGlassContainer(
      height: 140.h,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacing.vSpace(17.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Image.asset(
                    'assets/pnga/offerTest.png',
                    width: 100.w,
                    height: 100.h,
                  ),
                ),
                Spacing.hSpace(2.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Cappuccino',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Spacing.vSpace(12.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'buy 1 and get another 1 \n50% off',
                        style: TextStyle(
                          color: Colors.black.withOpacity(.6),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Spacing.vSpace(15.h),
                    Row(
                      children: [
                        Spacing.hSpace(10.w),
                        Text(
                          '\$',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          ' 3.12',
                          style: TextStyle(
                            color: Colors.white.withOpacity(.9),
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacing.hSpace(80.w),
                        Container(
                          width: 23.r,
                          height: 23.r,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.all(6),
                          child: SvgPicture.asset(
                            'assets/svgs/heartOutLine.svg',
                            color: Colors.white,
                          ),
                        ),
                        Spacing.hSpace(4.w),
                        Container(
                          width: 25.r,
                          height: 25.r,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.all(8),
                          child: SvgPicture.asset(
                            'assets/svgs/heartOutLine.svg',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
