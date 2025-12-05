import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/features/home/widgets/custom_search_feaild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SearchBarFilter extends StatelessWidget {
  const SearchBarFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
                    children: [
                      Expanded(child: DarkGlassSearchBar(height: 44.h,)),
                      Padding(
                        padding:  EdgeInsets.only(right: 10.w),
                        child: Container(
                          height: 43.h,
                          width: 50.h,
                          padding: EdgeInsets.all(16),
                          child: SvgPicture.asset(
                            'assets/svgs/filter.svg',
                          
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  );
  }
}