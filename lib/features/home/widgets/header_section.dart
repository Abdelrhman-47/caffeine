import 'package:caffeine/features/home/widgets/cursoul_slider_options.dart';
import 'package:caffeine/features/home/widgets/gradient_container.dart';
import 'package:caffeine/features/home/widgets/search_bar_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h, 
      child: Stack(
        children: [
          const GradientContainer(),
          Positioned(
            right: 0.w,
            top: 80.h,
            left: 0.w,
            child: const SearchBarFilter(),
          ),
          Positioned(
            right: 0.w,
            top: 130.h,
            left: 20.w,
            child: Text(
              'Exclusive Offer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            right: 20.w,
            bottom: -1.h,
            left: 20.w,
            child: const CursoulSliderOptions(),
          ),
        ],
      ),
    );
  }
}