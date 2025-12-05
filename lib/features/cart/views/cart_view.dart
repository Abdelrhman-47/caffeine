import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late final List<Color> _gradientColors;
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
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
  void dispose() {
    controller.dispose();
    super.dispose();
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
                  Expanded(
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                        return ListView.builder(
                          controller: controller,
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 12.h,
                          ),
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            double offset = 0;
                            if (controller.hasClients) {
                              offset = controller.offset / 130 - index;
                            }
                            offset = offset.clamp(0, 1);

                            return Transform.scale(
                              scale: 1 - (offset * 0.1),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: SizedBox(
                                  height: 150.h,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: DarkGlassContainer(
                                          height: 150.h,
                                        ),
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
                                        right: 20.w,
                                        top: 0,
                                        bottom: 0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'MilkShake',
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            SizedBox(height: 13.h),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: GlassContainer(
                                                    height: 30.h,
                                                    width: 30.w,
                                                    padding: EdgeInsets.all(
                                                      1.r,
                                                    ),
                                                    blur: 1,
                                                    color: AppColors
                                                        .primaryColor
                                                        .withOpacity(.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10.r,
                                                        ),
                                                    border: Border.all(
                                                      color: AppColors
                                                          .primaryColor,
                                                      width: 1.5,
                                                    ),
                                                    child: Icon(Icons.add),
                                                  ),
                                                ),
                                                Spacing.hSpace(6.w),
                                                Text(
                                                  '30',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                                Spacing.hSpace(6.w),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: GlassContainer(
                                                    height: 30.h,
                                                    width: 30.w,
                                                    padding: EdgeInsets.all(
                                                      1.r,
                                                    ),
                                                    blur: 1,
                                                    color: AppColors
                                                        .primaryColor
                                                        .withOpacity(.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10.r,
                                                        ),
                                                    border: Border.all(
                                                      color: AppColors
                                                          .primaryColor,
                                                      width: 1.5,
                                                    ),
                                                    child: Icon(Icons.add),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(height: 12.h),
                                            GestureDetector(
                                              onTap: () {},
                                              child: GlassContainer(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 16.w,
                                                  vertical: 6.h,
                                                ),
                                                blur: 1,
                                                color: AppColors.primaryColor
                                                    .withOpacity(.4),
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                border: Border.all(
                                                  color: AppColors.primaryColor,
                                                  width: 1.5,
                                                ),
                                                child: Text(
                                                  'Remove',
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
