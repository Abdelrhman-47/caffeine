import 'package:caffeine/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformationRow extends StatelessWidget {
  const InformationRow({super.key});

  @override
  Widget build(BuildContext context) {
    return    Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Good Morning..',
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: AppColors.secondaryColor.withOpacity(.4),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          
                          TextSpan(
                            text: '\n  Abdelrhman',
                            style: TextStyle(height: 1.h,
                              fontSize: 15.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                   Spacer(), CircleAvatar(radius: 27.r,)
                  ],
    );
  }
}