import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart' show Spacing;
import 'package:caffeine/core/routing/app_routes.dart';
import 'package:caffeine/core/sheared_widgets/custom_button.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  late final List<Color> _gradientColors;
  @override
  void initState() {
    super.initState();
    _gradientColors = [
      AppColors.secondaryColor.withOpacity(.5),
      AppColors.secondaryColor.withOpacity(.4),
      AppColors.secondaryColor.withOpacity(.3),
      Colors.white.withOpacity(.4),
      Colors.white.withOpacity(.4),
      Colors.white.withOpacity(.3),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _gradientColors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Spacing.vSpace(30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 25.sp,
                          color: Colors.white,
                        ),
                        Spacing.hSpace(88.w),
                        Text(
                          'order Place',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacing.vSpace(30.h),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: SizedBox(
                            height: 110.h,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: DarkGlassContainer(height: 100.h),
                                ),
                                Positioned(
                                  left: 10.w,
                                  top: -10.h,
                                  bottom: -10.h,
                                  child: Image.asset(
                                    'assets/pnga/d3.png',
                                    width: 120.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  left: 120.w,
                                  top: 5.h,
                                  bottom: 0,
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Spacing.vSpace(7.h),
                                      
                                          Text(
                                            'MilkShake',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Spacing.vSpace(7.h),
                                          Text(
                                            'count          ',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Spacing.vSpace(3.h),
                                      
                                          Text(
                                            'Total Price',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                      
                                          SizedBox(height: 1.h),
                                         
                                        ],
                                      ),
                                       Spacing.hSpace(70.w), Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Spacing.vSpace(7.h),
                                      
                                          Text(
                                            '',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Spacing.vSpace(7.h),
                                          Text(
                                            '10',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Spacing.vSpace(6.h),
                                      
                                          Text(
                                            '70 \$',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                      
                                          SizedBox(height: 1.h),
                                         
                                        ],)
                                    ],
                                  ),
                                ),
                          
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
               Positioned(right: 0,left: 0,bottom: 0,
                              child: DarkGlassContainer(
  height: 200.h,
  width: double.infinity,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(50.r),
    topRight: Radius.circular(50.r),
  ),
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Pricing breakdown rows
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Original Price',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  '\$ 41.98',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Use Coupon',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  '\$ 0.20',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fee',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  '\$ 0.04',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Divider(color: Colors.white.withOpacity(0.3), thickness: 1),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '\$ 41.82',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        
        // Action buttons row
        CustomButton(
          text: 'Confirm',
          onPressed: () {
            context.pushNamed(AppRoutes.order);
          },
          textColor: Colors.white,
          height: 45.h,
          width: 120.w,
          borderRadius: BorderRadius.circular(25.r),
          outLineButton: false,
          backgroundColor: AppColors.primaryColor,
          textStyle: TextStyle(
            fontSize: 14.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  ),))
],
        ),
      ),
    );
  }
}
