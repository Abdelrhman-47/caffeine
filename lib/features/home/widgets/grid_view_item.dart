import 'dart:ui';
import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/features/home/data/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.product});
final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 120, sigmaY: 450),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.grey.shade300,
                Colors.grey.shade400,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding:  EdgeInsets.all(7.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 InkWell(
                   onTap: () {
                     print('Added to cart');
                   },
                   child: SvgPicture.asset(
                     'assets/svgs/no_fav.svg',width: 10.w,height: 16.h,
                   
                   ),
                 ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: -10.h,
                      right: 0,
                      left: 0,
                      child: Image.asset(
                        'assets/pnga/shadow.png',width: 10.w,height: 35.h,
                        color: Colors.black26,
                      ),
                    ),
                    Center(
                      child: Image.network(
                        product.url,
                        width: 115.w,
                        height: 115.h,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          color:AppColors.primaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ), Spacing.vSpace(2.h),
                      Text(
                        'this is first coffe',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 6.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacing.vSpace(2.h),
                      Row(
                        children: [
                          Spacing.hSpace(1.w),
                          Text(
                           product.price,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Spacer(),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/rait.svg',width: 16.w,height: 16.h,
                              ),
                              Spacing.hSpace(2.w),
                              Text(
                           product.rate)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
