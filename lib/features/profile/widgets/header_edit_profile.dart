import 'package:caffeine/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderEditProfile extends StatelessWidget {
  const HeaderEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
            Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back_ios, size: 24.sp),
                        ),
                        Expanded(
                          child: Text(
                            'Edit Profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 48.w),
                      ],
                    ),
                  ),
    ],);
  }
}