import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/core/routing/app_routes.dart';
import 'package:caffeine/core/sheared_widgets/custom_button.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CartNav extends StatelessWidget {
  const CartNav({super.key});

  @override
  Widget build(BuildContext context) {
    return  DarkGlassContainer(
                        height: 130.h,
                        width: double.infinity,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.r),
                          topRight: Radius.circular(50.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Spacing.hSpace(20.w),
                                CustomButton(
                                  text: 'Back To Home',
                                  onPressed: () {
                                    context.pushNamed(AppRoutes.homeLayout);
                                  },
                                  textColor: Colors.white,
                                  height: 50.h,
                                  width: 120.w,
                                  borderRadius: BorderRadius.circular(12.r),
                                  outLineButton: false,
                                  backgroundColor: AppColors.primaryColor,
                                  textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(),
                                CustomButton(
                                  text: 'confirm order',
                                  onPressed: () {
                                    context.pushNamed(AppRoutes.order);
                                  },
                                  textColor: Colors.white,
                                  height: 50.h,
                                  width: 120.w,
                                  borderRadius: BorderRadius.circular(12.r),
                                  outLineButton: false,
                                  backgroundColor: AppColors.primaryColor,
                                  textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacing.hSpace(15.w),
                              ],
                            ),
                            // Text(
                            //   'Total price\n\$2.50',
                            //   style: TextStyle(
                            //     fontSize: 13.sp,
                            //     color: Colors.white,
                            //   ),
                            // ),
                          ],
                        ),
                      );
  }
}