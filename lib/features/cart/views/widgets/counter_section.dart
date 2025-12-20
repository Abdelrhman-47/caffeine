import 'package:caffeine/core/constants/app_colors.dart';
import 'package:caffeine/core/helpers/spacing.dart';
import 'package:caffeine/features/cart/cubit/counter_cubit/counter_cubit.dart';
import 'package:caffeine/features/home/widgets/glass_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CounterSection extends StatelessWidget {
  const CounterSection({super.key, required this.productId});
final int productId;
  @override
  Widget build(BuildContext context) {
    return     Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                          context.read<CounterCubit>().decrement(productId);
                          },
                          child: GlassContainer(
                            height: 30.h,
                            width: 30.w,
                            padding: EdgeInsets.all(1.r),
                            blur: 1,
                            color: AppColors.primaryColor.withOpacity(.4),
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1.5,
                            ),
                            child: Icon(Icons.minimize, color: Colors.white),
                          ),
                        ),
                        Spacing.hSpace(6.w),
                        Text(
                        context.watch<CounterCubit>().getCount(productId).toString(),
                          style: TextStyle(fontSize: 14.sp, color: Colors.white),
                        ),
                        Spacing.hSpace(6.w),
                        GestureDetector(
                          onTap: () {
                          context.read<CounterCubit>().increment(productId);
                          },
                          child: GlassContainer(
                            height: 30.h,
                            width: 30.w,
                            blur: 1,
                            color: AppColors.primaryColor.withOpacity(.4),
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1.5,
                            ),

                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ],
                    );
  }
}