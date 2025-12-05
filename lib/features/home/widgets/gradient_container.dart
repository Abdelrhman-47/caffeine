import 'package:caffeine/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
                  width: double.infinity,
                  height: 290.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: AlignmentGeometry.topCenter,
                      end: AlignmentGeometry.bottomCenter,
                      colors: [
                        AppColors.secondaryColor.withOpacity(.5),
                        AppColors.secondaryColor.withOpacity(.4),
                        AppColors.secondaryColor.withOpacity(.3),
                        Colors.white.withOpacity(.2),
                      ],
                    ),
                  ),
                );
  }
}