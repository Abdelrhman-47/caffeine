import 'dart:ui';
import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/features/favorite/cubit/fav_cubit.dart';
import 'package:caffeine/features/favorite/data/fav_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavItem extends StatelessWidget {
  const FavItem({super.key, required this.fav, required this.isFave});
  final ProductsModel fav;
  final bool isFave;
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
            padding: EdgeInsets.all(7.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    if (isFave != null) {
                      context.read<FavCubit>().deletFavProduct(fav.id);
                    }
                  },
                  child: SvgPicture.asset(
                    'assets/svgs/fav.svg',
                    width: 10.w,
                    height: 16.h,
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
                        'assets/pnga/shadow.png',
                        width: 10.w,
                        height: 35.h,
                        color: Colors.black26,
                      ),
                    ),
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: fav.url,
                        width: 115.w,
                        height: 115.h,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 115.w,
                          height: 115.h,
                          color: Colors.grey[300],
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.image),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fav.name,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacing.vSpace(2.h),
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
                            fav.price.toStringAsFixed(2),
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
                                'assets/svgs/rait.svg',
                                width: 16.w,
                                height: 16.h,
                              ),
                              Spacing.hSpace(2.w),
                              Text(fav.rate),
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
