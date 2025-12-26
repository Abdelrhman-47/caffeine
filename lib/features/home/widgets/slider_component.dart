import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/features/home/data/product_model.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SliderComponent extends StatelessWidget {
  const SliderComponent({super.key, required this.offer});
  final OfferModel offer;
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
                  child: CachedNetworkImage(
                    imageUrl: offer.url1,
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 100.w,
                      height: 100.h,
                      color: Colors.grey[300],
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.image),
                  ),
                ),
                Spacing.hSpace(2.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          offer.name,
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
                        offer.des,
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
                          offer.price.toStringAsFixed(1),
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
